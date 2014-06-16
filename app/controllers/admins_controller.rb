class AdminsController < ApplicationController
  
  def index
    
  end
  def leave
    user = session[:user]
    u = Staff.find_by_staffid(user)
    childdob = u.dobchild
    if !childdob.nil?
      childdob = childdob.to_date
    end
    dateemployed = u.dateemployed
    if !dateemployed.nil?
      dateemployed = dateemployed.to_date
    end
    today = Date.today
    if dateemployed.nil?
      annualLeave = 0
    else
      numYears = today.year-dateemployed.year
     
      numMonths = today.month-dateemployed.month
      numDays = today.day - dateemployed.day
      if numMonths > 0
        numYears = numYears + 1
        
        
      elsif numMonths == 0
        
        if numDays > 0
          numYears = numYears + 1
        end
      end
      
      
      if numYears == 1
        if numMonths < 0
          numMonths = numMonths + 12
        end
        if numDays < 0
          numMonths = numMonths - 1
        end
        if numMonths <= 3
          annualLeave = 2
        else
          annualLeave = numMonths.to_f/12*7.round
        end
      else
          annualLeave = 6 + numYears
          if annualLeave > 14
            annualLeave = 14
          end
      end
      
    end
    p numYears
    p numMonths
    p numDays
    
    if childdob.nil?
      childLeave = 0
    else
      childYears = today.year-childdob.year
      childMonths = today.month-childdob.month
      if childMonths > 0
        childYears = childYears + 1
      elsif childMonths == 0
        childDays = today.day - childdob.day
        if childDays > 0
          childYears = childYears + 1
        end
      end
      
      childYears = childYears - 1
      if childYears < 7
        childLeave = 6
        if numYears == 1
          if numMonths <= 3
            childLeave = 2
          else
            childLeave = numMonths.to_f/12*6.round
          end
        end
      elsif childYears < 13
        childLeave = 2
      else
        childLeave = 0
      end
    end
    
    
    
    @numAnnualLeave = annualLeave.round
    @numChildLeave = childLeave.round
    @leaves = Leave.where(staffid:user)
    @new_leave = Leave.new
  end
  
  def addLeave
    enddate = params[:leave][:dateend].to_date
    startdate = params[:leave][:datestart].to_date
    total = enddate - startdate + 1
    Leave.create(:datestart => startdate, :dateend => enddate, :leavetype => params[:leave][:leavetype], :reason => params[:leave][:reason], :total => total, :staffid => session[:user], :company => session[:company], :profession => session[:type], :approved => false)
    redirect_to :action => 'leave'
  end
  def leave_params
    params.require(:leave).permit!
  end
  
  def calendar
    leaves = Leave.all
    array = []
    leaves.each do |l|
      hash = {:title => l.staffid, :start => l.datestart, :end => l.dateend, :color => '#33FF00'}
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
    @leaves = Leave.all
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
    if session[:type] == "Staff"
      redirect_to :controller => 'pages', :action => 'staff'
    else
      redirect_to :controller => 'pages', :action => 'tele'
    end
  end
  
  def staff_params
    params.require(:staff).permit!
  end
end
