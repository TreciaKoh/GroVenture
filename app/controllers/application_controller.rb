class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
   # def calculateLeaves(user)
    # u = Staff.find_by_staffid(user)
    # childdob = u.dobchild
    # if !childdob.nil?
      # childdob = childdob.to_date
    # end
      # dateemployed = u.dateemployed
    # if !dateemployed.nil?
      # dateemployed = dateemployed.to_date
    # end
    # today = Date.today
    # if dateemployed.nil?
      # annualLeave = 0
    # else
      # numYears = today.year-dateemployed.year
# 
      # numMonths = today.month-dateemployed.month
      # fixedNumMonths = numMonths
      # numDays = today.day - dateemployed.day
      # if numMonths > 0
        # numYears = numYears + 1
# 
      # elsif numMonths == 0
# 
        # if numDays > 0
          # numYears = numYears + 1
        # end
      # end
# 
      # if numYears == 1
        # if numMonths < 0
          # numMonths = numMonths + 12
        # end
        # if numDays < 0
          # numMonths = numMonths - 1
        # end
        # if numMonths <= 3
          # annualLeave = 2
        # else
          # annualLeave = numMonths.to_f/12*7.round
        # end
      # else
        # annualLeave = 6 + numYears
        # if annualLeave > 14
          # annualLeave = 14
        # end
      # end
# 
    # end
    # p numYears
    # p numMonths
    # p numDays
# 
    # if childdob.nil?
      # childLeave = 0
    # else
      # childYears = today.year-childdob.year
      # childMonths = today.month-childdob.month
      # if childMonths > 0
        # childYears = childYears + 1
      # elsif childMonths == 0
        # childDays = today.day - childdob.day
        # if childDays > 0
          # childYears = childYears + 1
        # end
      # end
# 
      # childYears = childYears - 1
      # if childYears < 7
        # childLeave = 6
        # if numYears == 1
          # if numMonths <= 3
            # childLeave = 2
          # else
            # childLeave = numMonths.to_f/12*6.round
          # end
        # end
      # elsif childYears < 13
        # childLeave = 2
      # else
        # childLeave = 0
      # end
    # end
    # before = false
    # if !dateemployed.nil?
    # if fixedNumMonths == 0
      # if numDays <= 0
        # before = true
      # end
    # elsif fixedNumMonths < 0
      # before = true
    # end
    # yeartoday = today.year
    # if before == false
      # windowstart = Date.new(yeartoday, dateemployed.month, dateemployed.day)
      # windowend = Date.new(yeartoday + 1, dateemployed.month, dateemployed.day)
    # else
      # windowstart = Date.new(yeartoday -1, dateemployed.month, dateemployed.day)
      # windowend = Date.new(yeartoday, dateemployed.month, dateemployed.day)
    # end
    # leavestaken = Leave.where(datestart: windowstart..windowend, leavetype:"normal", staff_id:user, approved:1..2)
    # total = 0
    # totalcl = 0
    # totalmc = 0
    # totalunpaid = 0
    # leavestaken.each do |lt|
      # # duration = lt.dateend - lt.datestart
      # # total = total + duration + 1
      # # starttime = lt.starttime
      # # endtime = lt.endtime
      # # if starttime == 'AM' && endtime == 'PM'
      # # elsif starttime == 'PM' && endtime == 'AM'
        # # total = total - 1
      # # else
        # # total = total - 0.5
      # # end 
      # total = total + lt.total
    # end
#     
    # childleavestaken = Leave.where(datestart: windowstart..windowend, leavetype:"childcare", staff_id:user, approved:1..2)
    # childleavestaken.each do |lt|
      # # duration = lt.dateend - lt.datestart
      # # totalcl = totalcl + duration + 1
      # # starttime = lt.starttime
      # # endtime = lt.endtime
      # # if starttime == 'AM' && endtime == 'PM'
      # # elsif starttime == 'PM' && endtime == 'AM'
        # # totalcl = totalcl - 1
      # # else
        # # totalcl = totalcl - 0.5
      # # end 
      # totalcl = totalcl + lt.total
    # end
#    
    # mctaken = Leave.where(datestart: windowstart..windowend, leavetype:"medical", staff_id:user, approved:1..2)
    # mctaken.each do |lt|
      # # duration = lt.dateend - lt.datestart
      # # totalmc = totalmc + duration + 1
      # totalmc = totalmc + lt.total
    # end
    # unpaidtaken = Leave.where(datestart: windowstart..windowend, leavetype:"unpaid", staff_id:user, approved:1..2)
    # unpaidtaken.each do |lt|
      # # duration = lt.dateend - lt.datestart
      # # totalunpaid = totalunpaid + duration + 1
      # # starttime = lt.starttime
      # # endtime = lt.endtime
      # # if starttime == 'AM' && endtime == 'PM'
      # # elsif starttime == 'PM' && endtime == 'AM'
        # # totalunpaid = totalunpaid - 1
      # # else
        # # totalunpaid = totalunpaid - 0.5
      # # end 
      # totalunpaid = totalunpaid + lt.total
    # end
#     
    # return {"numUnpaid" => totalunpaid.to_f, "windowstart" => windowstart, "numAL" => annualLeave.round, "numCL" => childLeave.round, "numTaken" => (total).to_f, "childLeavesTaken" => (totalcl).to_f, "mcTaken" => (totalmc).to_f}
  # else
    # return {"numAL" => 0, "numCL" => 0, "numTaken" => 0, "childLeavesTaken" => 0, "mcTaken" => 0}
  # end
  # end
  # helper_method :calculateLeaves
  
  
  
  
  def calculateLeaves(user)
    u = Staff.find_by_staffid(user)
    if !u.dateemployed.nil?
      dateemployed = u.dateemployed.to_date
    else
      dateemployed = nil
    end
    if !u.dobchild.nil?
      childdob = u.dobchild.to_date
    else
      childdob = nil
    end
    today = Date.today
    if dateemployed.nil?
      annualLeave = 0
    else
      tier = u.tier
     
      yearsElapsed = today.year - dateemployed.year
      month = dateemployed.month
      annualLeave = 0
      if yearsElapsed != 0
        annualLeave = annualLeave.to_f + (yearsElapsed + 6).to_f/12*month
      end
      annualLeave = annualLeave.to_f + (yearsElapsed + 7).to_f/12*(12-month)
      
      if tier == 1
        annualLeave = annualLeave + 7
        if annualLeave > 21
          annualLeave = 21
        end
      else
        if annualLeave > 14
          annualLeave = 14
        end
      end
      
      
      
    end
    
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
        
      elsif childYears < 13
        childLeave = 2
      else
        childLeave = 0
      end
    end
    windowstart = Date.new(today.year, 1,1)
    windowend = Date.new(today.year, 12, 31)
    windowstart1 = Date.new(today.year-1, 1,1)
    windowend1 = Date.new(today.year-1, 12, 31)
    totalunpaid = 0
    unpaidtaken = Leave.where(datestart: windowstart..windowend, leavetype:"unpaid", staff_id:user, approved:1..2)
    unpaidtaken.each do |lt|
     
      totalunpaid = totalunpaid + lt.total
    end
    totalcl = 0
    childleavestaken = Leave.where(datestart: windowstart..windowend, leavetype:"childcare", staff_id:user, approved:1..2)
    childleavestaken.each do |lt|
      
      totalcl = totalcl + lt.total
    end
    totalmc = 0
    mctaken = Leave.where(datestart: windowstart..windowend, leavetype:"medical", staff_id:user, approved:1..2)
    mctaken.each do |lt|
      
      totalmc = totalmc + lt.total
    end
    
    leavestaken = Leave.where(datestart: windowstart..windowend, leavetype:"normal", staff_id:user, approved:1..2)
    total = 0
    leavestaken.each do |lt|
    
      total = total + lt.total
    end
    broughtforwardmonths = Setting.find_by_id(1).nummonths
    if (today.month <= broughtforwardmonths)
      leavestaken = Leave.where(datestart: windowstart1..windowend1, leavetype:"normal", staff_id:user, approved:1..2)
      total1 = 0
      leavestaken.each do |lt|
      
        total1 = total1 + lt.total
      end
      lastyearentitlement = annualLeave - 1
      tobringforward = lastyearentitlement - total1
    end
    
    entitledAL = annualLeave
    entitledAL += tobringforward if !tobringforward.nil?
    entitledCL = childLeave
    annualLeave = annualLeave.to_f/12*today.month
    annualLeave += tobringforward if !tobringforward.nil?
    childLeave = childLeave.to_f/12*today.month
    
    overwrittenleave = u.overwrittenleave
    cantakeoverwritten = nil
    if !overwrittenleave.nil?
      overwrittenon = u.overwrittenon.to_date if !u.overwrittenon.nil?
      overwrittenleave = overwrittenleave + (today.year-overwrittenon.year)
      if overwrittenleave > 21
        overwrittenleave = 21
      end
      cantakeoverwritten = overwrittenleave.to_f/12*today.month
    end
    return {"cantakeoverwritten" => cantakeoverwritten, "overwritten" => overwrittenleave, "numUnpaid" => totalunpaid.to_f, "entitledAL" => entitledAL, "entitledCL" => entitledCL, "numAL" => annualLeave.round, "numCL" => childLeave.round, "numTaken" => (total).to_f, "childLeavesTaken" => (totalcl).to_f, "mcTaken" => (totalmc).to_f}
    
    
  end
  helper_method :calculateLeaves
end
