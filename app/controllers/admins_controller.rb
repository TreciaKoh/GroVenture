class AdminsController < ApplicationController
  def index

  end
  
  def loginPage
    
  end
  
  def login
    userid = params[:userid]
    pass = params[:password]
    t = Staff.find_by(staffid:userid, profession:"tele")
    s = Staff.find_by(staffid:userid, profession:"staff")
    if !t.nil?

      if pass != t.password
        flash[:error] = "Wrong password!"
        redirect_to :action => 'loginPage'
      else
        session[:user] = userid

        session[:type] = "Telemarketer"
        company = t.company
        session[:company]= company
        session[:tier]= t.tier
        LoginLog.create(:userid => userid, :logintime => DateTime.current)
        if company == 'dreamwrkz'
          redirect_to :controller => 'pages',:action => 'tele'
        elsif company == 'groventure'
          redirect_to :controller => 'pagesgro',:action => 'tele'
        end
        
      end

    elsif !s.nil?
      if pass != s.password
        flash[:error] = "Wrong password!"
        redirect_to :action => 'loginPage'
      else
        session[:user] = userid
        session[:type] = "Staff"
        company = s.company
        session[:company]= company
        session[:tier] = s.tier
        LoginLog.create(:userid => userid, :logintime => DateTime.current)
       if company == 'dreamwrkz'
          redirect_to :controller => 'pages',:action => 'staff'
        elsif company == 'groventure'
          redirect_to :controller => 'pagesgro',:action => 'staff'
        end
      end

    elsif userid == "master"
      if pass != "master"
        flash[:error] = "Wrong password!"
        redirect_to :action => 'loginPage'
      else
        session[:user] = userid
        session[:type] = "Master"
        session[:company]= nil
        session[:tier] = 0
        LoginLog.create(:userid => userid, :logintime => DateTime.current)
        redirect_to :action => 'calendar'
      end

    else
      flash[:error] = "Invaid credentials!"
        redirect_to :action => 'loginPage'
    end
  end
 
  def logout
    session[:user]=nil
    session[:type]=nil
    session[:company]= nil
    redirect_to :action => 'loginPage'
  end

  def leave
    user = session[:user]
    
    
    hash = calculateLeaves(user)
    entitledOverwritten = hash["overwritten"]
    overwritten = hash["cantakeoverwritten"]
    if entitledOverwritten.nil?
       @numALEntitled = hash["entitledAL"]
       @numAnnualLeave = hash["numAL"]
    else
       @numALEntitled = entitledOverwritten
       @numAnnualLeave = overwritten
    end
    @numCLEntitled = hash["entitledCL"]
    
    @numChildLeave = hash["numCL"]
    @leavestaken = hash["numTaken"]
    
    @childleavestaken = hash["childLeavesTaken"]
    @mctaken = hash["mcTaken"]
    @leavesleft = {"normal" => @numAnnualLeave - @leavestaken, "child" => @numChildLeave - @childleavestaken, "mc" => 14 - @mctaken}
    @leaves = Leave.where(staff_id:user)
    @new_leave = Leave.new
    @windowstart = hash["windowstart"]
    @numUnpaid = hash["numUnpaid"]
  end

  def addLeave
    if params[:leave][:dateend] == "" || params[:leave][:datestart] == "" || params[:leave][:leavetype] == ""
      redirect_to :action => 'leave'
    else
      user = session[:user]
      hash = calculateLeaves(user)
      @numAnnualLeave = hash["numAL"]
      @numChildLeave = hash["numCL"]
      @leavestaken = hash["numTaken"]
      
      @childleavestaken = hash["childLeavesTaken"]
      @mctaken = hash["mcTaken"]
      @leavesleft = {"normal" => @numAnnualLeave - @leavestaken, "child" => @numChildLeave - @childleavestaken, "mc" => 14 - @mctaken}
      leavetype = params[:leave][:leavetype]
      
      enddate = params[:leave][:dateend].to_date
      startdate = params[:leave][:datestart].to_date
      total = enddate - startdate + 1
      starttime = params[:leave][:starttime]
      endtime = params[:leave][:endtime]
      my_days = [0,6]
      result = (startdate..enddate).to_a.select {|k| my_days.include?(k.wday)}
      total = total - result.size
      if starttime == 'AM' && endtime == 'PM'
      elsif starttime == 'PM' && endtime == 'AM'
        total = total - 1
      else
        total = total - 0.5
      end 
      problem = false
      if leavetype == 'normal'
        if @leavesleft["normal"] < total
          problem = true
        end
      elsif leavetype == 'childcare'
        if @leavesleft["child"] < total
          problem = true
        end
      elsif leavetype == 'medical'
        if @leavesleft["mc"] < total
          problem = true
        end
      end
      if problem
        flash[:error] = 'Not enough leave left!'
      else
         Leave.create(:datestart => startdate, :dateend => enddate, :leavetype => params[:leave][:leavetype], :reason => params[:leave][:reason], :total => total, :staff_id => session[:user], :company => session[:company], :profession => session[:type], :approved => 0)
      end
     
      redirect_to :action => 'leave'
    end
  end

  def leave_params
    params.require(:leave).permit!
  end

  def calendar
    if params[:selection].nil? || params[:selection] == 'All'
      leaves = Leave.all
    elsif params[:selection] == 'Dreamwrkz'
      leaves = Leave.where(company:'dreamwrkz')
    else
      leaves = Leave.where(company:'groventure')
    end
    
    array = []
    leaves.each do |l|
      hash = {:title => l.staff_id + ", " + l.leavetype, :start => l.datestart, :end => l.dateend + 1, :color => '#33FF00'}
      if l.approved == 0
        hash[:color] = 'red'
      elsif l.approved == 2
        hash[:color] = 'yellow'
      end
      array<<hash
    end
    doublequotes = array.to_json
    @result = array.to_json
  #@result = doublequotes.gsub('"', '\'')
  end

  def approveleave
    tier = params[:tier]
    under = params[:under]
    if under.nil? || under == 'master'
      @leaves = Leave.joins("INNER JOIN staffs ON staffs.staffid = leaves.staff_id").where(approved:0, :staffs => {:tier => tier})
      @leavesapproved = Leave.joins("INNER JOIN staffs ON staffs.staffid = leaves.staff_id").where(approved:1, :staffs => {:tier => tier})
      @leavestocancel = Leave.joins("INNER JOIN staffs ON staffs.staffid = leaves.staff_id").where(approved:2, :staffs => {:tier => tier})
      @tier = tier 
    else
      @leaves = Leave.joins("INNER JOIN staffs ON staffs.staffid = leaves.staff_id").where(approved:0, :staffs => {:workingunder => under})
      @leavesapproved = Leave.joins("INNER JOIN staffs ON staffs.staffid = leaves.staff_id").where(approved:1, :staffs => {:workingunder => under})
      @leavestocancel = Leave.joins("INNER JOIN staffs ON staffs.staffid = leaves.staff_id").where(approved:2, :staffs => {:workingunder => under})
    end
    
  end
  
  def requestCancel
    @l = Leave.find_by_id(params[:id])
    # l.update_attribute(:approved, 2)
    # redirect_to :action => 'leave'
  end
  def requestCancel2
    l = Leave.find_by_id(params[:leave][:id])
    l.update_attribute(:approved, 2)
    l.update_attribute(:reason, params[:leave][:reason])
    redirect_to :action => 'leave'
  end
  
  def removeRequestCancel
    person = params[:person]
    l = Leave.find_by_id(params[:id])
    l.update_attribute(:approved, 1)
    if person=='manager'
      redirect_to :action => 'approveleave', :under => session[:user], :tier => params[:tier]
    else
      redirect_to :action => 'leave'
    end
  end

  def approve
    l = Leave.find_by_id(params[:id])
    l.update_attribute(:approved, 1)
    redirect_to :action => 'approveleave', :under => session[:user], :tier => params[:tier]
  end

  def reject
    l = Leave.find_by_id(params[:id])
    l.update_attribute(:approved, 0)
    redirect_to :action => 'approveleave', :under => session[:user], :tier => params[:tier]
  end

  def deleteRecord
    person = params[:person]
    l = Leave.find_by_id(params[:id])
    l.delete
    if person=='manager'
      redirect_to :action => 'approveleave'
    else
      redirect_to :action => 'leave'
    end
    
  end

  def editRecord
    @leave = Leave.find_by_id(params[:id])

  end

  def updateLeave
    l = Leave.find_by_id(params[:leave][:id])
    enddate = params[:leave][:dateend].to_date
    startdate = params[:leave][:datestart].to_date
    total = enddate - startdate + 1
    
    starttime = params[:leave][:starttime]
    endtime = params[:leave][:endtime]
    my_days = [0,6]
    result = (startdate..enddate).to_a.select {|k| my_days.include?(k.wday)}
    total = total - result.size
    if starttime == 'AM' && endtime == 'PM'
    elsif starttime == 'PM' && endtime == 'AM'
      total = total - 1
    else
      total = total - 0.5
    end 
    l.update_attributes(leave_params)
    l.update_attribute(:total, total)
    redirect_to :action => 'leave'

  end

  def profile
    @user = Staff.find_by_staffid(session[:user])
  end

  def updateProfile
    s = Staff.find_by_id(params[:staff][:id])
    s.update_attributes(staff_params)
    if session[:type] == "Staff" && session[:company] == 'dreamwrkz'
      redirect_to :controller => 'pages', :action => 'staff'
    elsif session[:type] == "Telemarketer" && session[:company] == 'dreamwrkz'
      redirect_to :controller => 'pages', :action => 'tele'
     elsif session[:type] == "Staff" && session[:company] == 'groventure'
      redirect_to :controller => 'pagesgro', :action => 'staff'
    elsif session[:type] == "Telemarketer" && session[:company] == 'groventure'
      redirect_to :controller => 'pagesgro', :action => 'tele' 
    end
  end

  def staff_params
    params.require(:staff).permit!
  end
  
  def manageemployees
    @tier1employees = Staff.where(tier:1)
  end
  
  def addRemove
    @new_user = Staff.new
    @employees = Staff.all
  end
  
  def delete
    s = Staff.find_by_id(params[:id])
    s.delete
    redirect_to :action => 'addRemove'
  end
  
   def adduser
    Staff.create(staff_params)
    redirect_to :action => 'manageemployees'
  end
  
  def workingunder
    id = params[:id]
    manager = Staff.find_by_id(id)
    @name = manager.staffid
    @id = id
    @managertier = manager.tier
    @staffunder = Staff.where(workingunder:manager.staffid)
    @tier2employees = Staff.where(tier:@managertier+1)
  end
  
  def addworkingunder
    id = params[:staff]
    under = Staff.find_by_id(id)
    under.update_attribute(:workingunder, params[:managerid])
    managerid = params[:manageridid]
    redirect_to :back
  end
  
  def removeworkingunder
    id = params[:id]
    s = Staff.find_by_id(id)
    s.update_attribute(:workingunder, nil)
    redirect_to :back
  end
  
  def employeeinfo
    under = params[:under]
    if under.nil? || under=='master'
      @employees = Staff.all
    else
      @employees = Staff.where(workingunder:under)
    end
    
  end
  
  def changeinfo
    id = params[:id]
    @var = params[:var]
    @staff = Staff.find_by_id(id)
  end
  
  def updatestaffinfo
    s = Staff.find_by_id(params[:staff][:id])
    s.update_attributes(staff_params)
    redirect_to :action => 'employeeinfo', :under => session[:user]
  end
  
  def edit
    @staff = Staff.find_by_id(params[:id])
  end
  def edit2
     s = Staff.find_by_id(params[:staff][:id])
     s.update_attributes(staff_params)
     redirect_to :action => 'addRemove'
  end
  
   def loginRecord
    @login_records = LoginLog.all
  end
  
  def organstructure
    @tier1employees = Staff.where(tier:1)
  end
  
  def setdefaultleave
    id = params[:id]
    s = Staff.find_by_id(id)
    s.update_attribute(:overwritttenleave, nil)
    s.update_attribute(:overwrittenon, nil)
    redirect_to :back
  end
  
  def changepassword
    
  end
  def changepassword2
    user = Staff.find_by_staffid(session[:user])
    oldpassword = params[:oldpassword]
    newpassword = params[:newpassword]
    if user.password != oldpassword
      flash[:error] = 'Old password is wrong!'
    else
      user.update_attribute(:password, newpassword)
      flash[:error] = 'Password changed!'
    end
    redirect_to :back
  end
  
  def viewsales
    @result = []
    users = Staff.all
    users.each do |u|
      company = u.company
      if company == 'dreamwrkz'
        records = MainRecord.where(attendedBy:u.staffid).size
        numclosed = MainRecord.where(attendedBy:u.staffid, closed:true).size
      elsif company == 'groventure'
        records = MainRecordGro.where(attendedBy:u.staffid).size
        numclosed = MainRecordGro.where(attendedBy:u.staffid, closed:true).size
      end
      @result << {"staff"=>u.staffid, "total"=>records, "closed" =>numclosed, "percentage" => numclosed.to_f/records*100}
    end
  end
  
  def setbroughtforward
    
  end
  def setbroughtforward2
    s = Setting.find_by_id(1)
    s.update_attribute(:nummonths, params[:num])
    @success = 'Successfully changed'
    redirect_to :back
  end
end
