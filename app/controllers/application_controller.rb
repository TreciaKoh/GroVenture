class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
   def calculateLeaves(user)
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
      fixedNumMonths = numMonths
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
    before = false
    if !dateemployed.nil?
    if fixedNumMonths == 0
      if numDays <= 0
        before = true
      end
    elsif fixedNumMonths < 0
      before = true
    end
    yeartoday = today.year
    if before == false
      windowstart = Date.new(yeartoday, dateemployed.month, dateemployed.day)
      windowend = Date.new(yeartoday + 1, dateemployed.month, dateemployed.day)
    else
      windowstart = Date.new(yeartoday -1, dateemployed.month, dateemployed.day)
      windowend = Date.new(yeartoday, dateemployed.month, dateemployed.day)
    end
    leavestaken = Leave.where(datestart: windowstart..windowend, leavetype:"normal", staff_id:user, approved:true)
    total = 0
    totalcl = 0
    totalmc = 0
    totalunpaid = 0
    leavestaken.each do |lt|
      duration = lt.dateend - lt.datestart
      total = total + duration + 1
    end
    
    childleavestaken = Leave.where(datestart: windowstart..windowend, leavetype:"childcare", staff_id:user, approved:true)
    childleavestaken.each do |lt|
      duration = lt.dateend - lt.datestart
      totalcl = totalcl + duration + 1
    end
   
    mctaken = Leave.where(datestart: windowstart..windowend, leavetype:"medical", staff_id:user, approved:true)
    mctaken.each do |lt|
      duration = lt.dateend - lt.datestart
      totalmc = totalmc + duration + 1
    end
    unpaidtaken = Leave.where(datestart: windowstart..windowend, leavetype:"unpaid", staff_id:user, approved:true)
    unpaidtaken.each do |lt|
      duration = lt.dateend - lt.datestart
      totalunpaid = totalunpaid + duration + 1
    end
    
    return {"numUnpaid" => totalunpaid.to_i, "windowstart" => windowstart, "numAL" => annualLeave.round, "numCL" => childLeave.round, "numTaken" => (total).to_i, "childLeavesTaken" => (totalcl).to_i, "mcTaken" => (totalmc).to_i}
  else
    return {"numAL" => 0, "numCL" => 0, "numTaken" => 0, "childLeavesTaken" => 0, "mcTaken" => 0}
  end
  end
  helper_method :calculateLeaves
end
