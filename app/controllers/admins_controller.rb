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
    @leaves = Leave.where(staff_id:user)
    @new_leave = Leave.new
    @windowstart = hash["windowstart"]
    @numUnpaid = hash["numUnpaid"]
  end

  def addLeave
    if params[:leave][:dateend] == "" || params[:leave][:datestart] == "" || params[:leave][:leavetype] == ""
      redirect_to :action => 'leave'
    else
      enddate = params[:leave][:dateend].to_date
      startdate = params[:leave][:datestart].to_date
      total = enddate - startdate + 1
      Leave.create(:datestart => startdate, :dateend => enddate, :leavetype => params[:leave][:leavetype], :reason => params[:leave][:reason], :total => total, :staff_id => session[:user], :company => session[:company], :profession => session[:type], :approved => false)
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
      hash = {:title => l.staff_id, :start => l.datestart, :end => l.dateend, :color => '#33FF00'}
      if l.approved == false
        hash[:color] = 'red'
      end
      array<<hash
    end
    doublequotes = array.to_json
    @result = array.to_json
  #@result = doublequotes.gsub('"', '\'')
  end

  def approveleave
    @leaves = Leave.joins("INNER JOIN staffs ON staffs.staffid = leaves.staff_id").where(approved:false)
    @leavesapproved = Leave.joins("INNER JOIN staffs ON staffs.staffid = leaves.staff_id").where(approved:true)
  end

  def approve
    l = Leave.find_by_id(params[:id])
    l.update_attribute(:approved, true)
    redirect_to :action => 'approveleave'
  end

  def reject
    l = Leave.find_by_id(params[:id])
    l.update_attribute(:approved, false)
    redirect_to :action => 'approveleave'
  end

  def deleteRecord
    l = Leave.find_by_id(params[:id])
    l.delete
    redirect_to :action => 'leave'
  end

  def editRecord
    @leave = Leave.find_by_id(params[:id])

  end

  def updateLeave
    l = Leave.find_by_id(params[:leave][:id])
    enddate = params[:leave][:dateend].to_date
    startdate = params[:leave][:datestart].to_date
    total = enddate - startdate + 1
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
