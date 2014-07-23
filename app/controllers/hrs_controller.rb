class HrsController < ApplicationController
  # u = Staff.find_by_staffid(user)
  
  
  def attendance
    @user = Staff.find_by_staffid(session[:user])
    @staffs = Staff.all
    @attendances = Attendance.all
    d = 1
    d = Attendance.find_by_date(params[:date]) if !params[:date].nil?  && !params[:date].empty?

    if d.nil?

    redirect_to :action => 'newattendance', :date => params[:date]
    elsif d == 1
      
    else
      redirect_to :action => 'editattendance', :date => params[:date]
     
    end
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
    sql = "SELECT * FROM attendances INNER JOIN staffs ON staffs.staffid = attendances.staffid "
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
  
  
  
end
