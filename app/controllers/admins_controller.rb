class AdminsController < ApplicationController
  def index

  end
  
 

  def leave
    user = session[:user]
    
    
    hash = calculateLeaves(user)
    @numAnnualLeave = hash["numAL"]
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
    @leaves = Leave.joins("INNER JOIN staffs ON staffs.staffid = leaves.staff_id").where(approved:0)
    @leavesapproved = Leave.joins("INNER JOIN staffs ON staffs.staffid = leaves.staff_id").where(approved:1)
    @leavestocancel = Leave.joins("INNER JOIN staffs ON staffs.staffid = leaves.staff_id").where(approved:2)
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
    l = Leave.find_by_id(params[:id])
    l.update_attribute(:approved, 1)
    if session[:type] == 'Master'
      redirect_to :action => 'approveleave'
    else
      redirect_to :action => 'leave'
    end
  end

  def approve
    l = Leave.find_by_id(params[:id])
    l.update_attribute(:approved, 1)
    redirect_to :action => 'approveleave'
  end

  def reject
    l = Leave.find_by_id(params[:id])
    l.update_attribute(:approved, 0)
    redirect_to :action => 'approveleave'
  end

  def deleteRecord
    l = Leave.find_by_id(params[:id])
    l.delete
    if session[:type] == 'Master'
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
end
