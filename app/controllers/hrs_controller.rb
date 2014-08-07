class HrsController < ApplicationController
  # u = Staff.find_by_staffid(user)
  def attendance
    @user = Staff.find_by_staffid(session[:user])
    @staffs = Staff.all
    @date = params[:date]
  # d = 1
  # d = Attendance.find_by_date(params[:date]) if !params[:date].nil?  && !params[:date].empty?
  #
  # if d.nil?
  #
  # redirect_to :action => 'newattendance', :date => params[:date]
  # elsif d == 1
  #
  # else
  # redirect_to :action => 'editattendance', :date => params[:date]
  #
  # end
  end

  def addattendance
    size = Staff.all.size
    for i in 0..size-1
      a = "staffid"+i.to_s
      b = "timein"+i.to_s
      c = "status"+i.to_s
      Attendance.create(:staffid => params[a], :timein => params[b], :leavetype =>params[c], :date => params[:selectedDate])
    end
    redirect_to :action => 'attendance'
  end

  def newattendance
    @selectedDate = params[:date]
    @user = Staff.find_by_staffid(session[:user])
    @staffs = Staff.all
    @attendances = Attendance.all
    d = Attendance.find_by_date(params[:date])
  end

  def editattendance
    @selectedDate = params[:date]
    @user = Staff.find_by_staffid(session[:user])
    @staffs = Staff.all
    @attendances = Attendance.all
    @dates = Attendance.where(:date => params[:date])

    # @dates inner join @staffs where staffid
    sql = "SELECT * FROM attendances INNER JOIN staffs ON staffs.staffid = attendances.staffid where date = '"+@selectedDate+"'"
    p sql
    @list = Attendance.find_by_sql(sql)
  end

  def editattendancebydate
    size = Staff.all.size
    for i in 0..size-1
      a = "staffid"+i.to_s
      b = "timein"+i.to_s
      c = "status"+i.to_s
      s = Attendance.find_by(:date => params[:date], :staffid => params[a])
      s.update_attributes(:timein => params[b], :leavetype => params[c])

    end

    redirect_to :action => 'attendance'

  end

  def viewattendance
    @selectedDate = params[:date]
    @user = Staff.find_by_staffid(session[:user])
    @staffs = Staff.all
    @attendances = Attendance.all
    @dates = Attendance.where(:date => params[:date])

    # @dates inner join @staffs where staffid
    sql = "SELECT * FROM attendances INNER JOIN staffs ON staffs.staffid = attendances.staffid "
    @list = Attendance.find_by_sql(sql)
  end

  def viewattendancebydate
    @selectedDate = params[:date]
    @user = Staff.find_by_staffid(session[:user])
    @staffs = Staff.all
    @attendances = Attendance.all
    @dates = Attendance.where(:date => :date1..:date2)
    # @dates inner join @staffs where staffid
    sql = "SELECT * FROM attendances INNER JOIN staffs ON staffs.staffid = attendances.staffid"
    @list = Attendance.find_by_sql(sql)

  end

  def calculatepay
    @staff = Staff.all
  end

  def calculate
    staffid = params[:staffid]
    @company = Staff.find_by_staffid(staffid).company
    month = params[:month]
    year = params[:year]
    attendance = Attendance.where(:staffid => staffid)
    total = 0.to_f
   
    attendance.each do |a|
    
      if a.date.year.to_s == year && a.date.month.to_s == month
       
        if a.leavetype == 'half'
        total += 0.5
        else
        total += 1
        end
      end
    end
    addAttendance = false
    array = ['January', 'February', 'March','April','May','June','July','August','September','October','November','December']
    workingday = Workingday.find_by(:year => Date.today.year, :month => array[month.to_i-1])
    if workingday.nil?
      if 22-total <=3
      addAttendance = true
      end
    else
      if workingday.days - total <=3
      addAttendance = true
      end
    end
    @total = total
    finalrecords = []
    sp = Staffpay.find_by_staffid(Staff.find_by_staffid(staffid).id)
    if !sp.nil?
      records = MainRecord.where(apptBy: staffid)
      records2 = MainRecordGro.where(apptBy: staffid)
      records = records + records2
      
      records.each do |r| 
       
        if r.dateAppt.year == year.to_i && r.dateAppt.month == month.to_i
          finalrecords << r
        end
      end
      @sumsales = 0.0
      finalrecords.each do |f|
        if f.onhold != true
          @sumsales += f.closedamount
        end
      end
      @finalrecords = finalrecords
      @staffid = staffid
      @month = array[month.to_i-1]
      @basic = sp.basic
      @employercpf = sp.employerCpf
      @employeecpf = sp.employeeCpf
      if addAttendance
        @attendanceincentive = sp.attendance
      else
        @attendanceincentive = 0
      end
      @performance = sp.performance
      @commissionrate = sp.commission
      @commission = @commissionrate/100*@sumsales
      @deduction = sp.deduction
      @employercontribution = (@employercpf/100)*@basic
      @pay = (100.to_f-@employeecpf)/100*@basic+@attendanceincentive+@performance+@commission-@deduction
      @month = month
      @year = year
    else
      flash[:error] = 'Data for employee not set!'
    end
  end

  def realattendance
    present = []
    half = []
    present = params[:present] if !params[:present].nil?
    half = params[:half] if !params[:half].nil?
    intersect = present &half
    union = present | half|
    staff = Staff.all
    allstaff = []
    staff.each do |s|
      allstaff<<s.staffid
    end
    subtracted = allstaff - union

    if intersect.size != 0
      flash[:error] = "Error!"
    else
      subtracted.each do |sub|
        a = Attendance.find_by_staffid_and_date(sub, params[:date])
        a.delete if !a.nil?
      end
      present.each do |p|
        a = Attendance.find_by_staffid_and_date(p, params[:date])
        a.delete if !a.nil?
        Attendance.create(:staffid => p, :date => params[:date], :timein => params['timein'+p])

      end
      half.each do |h|
        a = Attendance.find_by_staffid_and_date(p, params[:date])
        a.delete if !a.nil?
        Attendance.create(:staffid => h, :date => params[:date], :timein => params['timein'+h], :leavetype => 'half')
      end
    end
    redirect_to :back

  end

  def extraleave
    staff= Staff.all
    @names = []
    @names << 'All'
    staff.each do |s|
      @names <<s.staffid
    end

    @extraleaves = Extraleave.all
  end

  def addextraleave
    staffid = params[:staff]
    leave = params[:leave]
    reason = params[:reason]
    staff = Staff.all
    if staffid == 'All'
      staff.each do |s|
        Extraleave.create(:staffid => s.staffid, :leave => leave, :reason => reason, :validtill => params[:validtill])
      end
    else
      Extraleave.create(:staffid => staffid, :leave => leave, :reason => reason, :validtill => params[:validtill])
    end
    redirect_to :back
  end

  def deleteextra
    e = Extraleave.find_by_id(params[:id])
    e.delete
    redirect_to :back
  end
  def index
    @extraleaves = Extraleave.all
  end
    def indexAttendance
    @attendances = Attendance.all
  end
  
  def togglehold
    company = params[:company]
    if company == 'dreamwrkz'
      r = MainRecord.find_by_id(params[:id])
    else
      r = MainRecordGro.find_by_id(params[:id])
    end
    if r.onhold
      r.update_attribute(:onhold, false)
    else
      r.update_attribute(:onhold, true)
    end
    redirect_to :action => 'calculate', :staffid => params[:staffid], :year => params[:year], :month => params[:month], :company => params[:company]
  end
end
