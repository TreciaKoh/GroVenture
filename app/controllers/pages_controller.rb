class PagesController < ApplicationController
  def tele
    id = session[:user]
    @records = MainRecord.where(apptBy:id)
    @new_record = MainRecord.new
  end

  def staff
    id = session[:user]
    @records1 = MainRecord.where(apptBy:id)
    @records2 = MainRecord.where(attendedBy:id)
    @records = @records1 + @records2
    @records = @records.uniq
    @new_record = MainRecord.new
    @staff = Staff.all
  end

  def company
    # p params[:selections]
    # p params[:startdate]
    # p params[:enddate]
    if params[:selections].nil? && (params[:startdate]=="" || params[:enddate]=="" || params[:startdate].nil? || params[:enddate].nil? )
      @records = MainRecord.all
    else
      if !params[:selections].nil?
        gradearray = params[:selections]
        @records1 = []
        gradearray.each do |g|
          @records1 = @records1 + MainRecord.where(attendedByGrade:g)
        end
      end
      if (params[:startdate]!="") && (params[:enddate]!="")
        sd = params[:startdate].to_date
        ed = params[:enddate].to_date
        @records2 = MainRecord.where(:dateAppt => sd.beginning_of_day..ed.end_of_day)
      end

      if params[:startdate]!="" && params[:enddate]!="" && !params[:selections].nil?
        @records = @records1 & @records2
        p "did one"
      elsif !params[:selections].nil? && !(params[:startdate]!="" && params[:enddate]!="")
        p "did two"
        @records = @records1
      else
        p "did this"
        @records = @records2
      end
    end

    @staff = Staff.all
    @telemarketers = Telemarketer.all
  end

  def overall
    @records = MainRecord.all
  end

  def add
    r = MainRecord.new
    r.companyName = params[:main_record][:companyName]
    r.address = params[:main_record][:address]
    r.postalCode = params[:main_record][:postalCode]
    r.contactPerson = params[:main_record][:contactPerson]
    r.position = params[:main_record][:position]
    r.hp = params[:main_record][:hp]
    r.office = params[:main_record][:office]
    r.email = params[:main_record][:email]
    r.apptBy = session[:user]
    r.dateAppt = params[:main_record][:dateAppt]
    r.remarks = params[:main_record][:remarks]
    r.attendedBy = params[:main_record][:attendedBy]
    r.attendedByGrade = params[:main_record][:attendedByGrade]
    r.attendedByRemarks = params[:main_record][:attendedByRemarks]
    r.save
    if session[:type]=="Telemarketer"
      redirect_to :action => 'tele'
    elsif session[:type]=="Staff"
      redirect_to :action => 'staff'

    end

  end

  def update
    m = MainRecord.find_by_id(params[:id])
    m.update_attribute(:attendedBy, params[:staff])
    m.update_attribute(:attendedByGrade, params[:grade])
    m.update_attribute(:attendedByRemarks, params[:remarks])

    redirect_to :action => 'company'
  end

  def loginPage

  end

  def login
    userid = params[:userid]
    pass = params[:password]
    t = Telemarketer.find_by_teleid(userid)
    s = Staff.find_by_staffid(userid)
    if !t.nil?

      if pass != t.password
        flash[:error] = "Wrong password!"
        redirect_to :action => 'loginPage'
      else
        session[:user] = userid

        session[:type] = "Telemarketer"
        LoginLog.create(:userid => userid, :logintime => DateTime.current)
        redirect_to :action => 'tele'
      end

    elsif !s.nil?
      if pass != s.password
        flash[:error] = "Wrong password!"
        redirect_to :action => 'loginPage'
      else
        session[:user] = userid
        session[:type] = "Staff"
        redirect_to :action => 'staff'
      end

    elsif userid == "master"
      if pass != "master"
        flash[:error] = "Wrong password!"
        redirect_to :action => 'loginPage'
      else
        session[:user] = userid
        session[:type] = "Master"
        redirect_to :action => 'company'
      end

    else
      redirect_to :action => 'overall'
    end
  end

  def logout
    session[:user]=nil
    session[:type]=nil
    redirect_to :action => 'loginPage'
  end

  def edit
    type = params[:type]
    id = params[:id]
    if type == "staff"
      @new_staff = Staff.find_by_id(id)
      @type = 'staff'
    else
      @new_staff = Telemarketer.find_by_id(id)
      @type = 'telemarketer'
    end
  end

  def edit2
    if params[:type] == 'staff'
      new_staff = Staff.find_by_id(params[:staff][:id])
      new_staff.update_attribute(:staffid, params[:staff][:staffid])
      new_staff.update_attribute(:password, params[:staff][:password])
    else
      new_staff = Telemarketer.find_by_id(params[:telemarketer][:id])
      new_staff.update_attribute(:teleid, params[:telemarketer][:teleid])
      new_staff.update_attribute(:password, params[:telemarketer][:password])
    end
    redirect_to :action => 'company'

  end

  def delete
    if params[:type] == 'staff'
      s = Staff.find_by_id(params[:id])
    s.delete
    else
      s = Telemarketer.find_by_id(params[:id])
    s.delete
    end
    redirect_to :action => 'company'
  end

  def adduser
    if params[:type]=='Staff'
      Staff.create(:staffid => params[:username], :password => params[:password])
    else
      Telemarketer.create(:teleid => params[:username], :password => params[:password])
    end
    redirect_to :action => 'company'
  end

  def editRecord
    @new_record = MainRecord.find_by_id(params[:id])
    @staff = Staff.all
  end

  def editRecord2
    r = MainRecord.find_by_id(params[:main_record][:id])
    # r.update_attributes(:companyName => params[:main_record][:companyName],:address => params [:main_record][:address],:postalCode => params[:main_record][:postalCode],:contactPerson => params[:main_record][:contactPerson],:position => params[:main_record][:position],:hp => params[:main_record][:hp],:office => params[:main_record][:office],:email =>params [:main_record][:email],:dateAppt => params[:main_record][:dateAppt],:remarks => params[:main_record][:remarks])
    r.update_attributes(:companyName=>params[:main_record][:companyName],:address=>params[:main_record][:address],:postalCode=>params[:main_record][:postalCode],:contactPerson=>params[:main_record][:contactPerson],:position=>params[:main_record][:position],:hp=>params[:main_record][:hp],:office=>params[:main_record][:office],:email=>params[:main_record][:email],:dateAppt=>params[:main_record][:dateAppt],:remarks=>params[:main_record][:remarks])
    if session[:type]=='Staff'
      r.update_attributes(:attendedBy =>params[:main_record][:attendedBy],:attendedByGrade =>params[:main_record][:attendedByGrade],:attendedByRemarks =>params[:main_record][:attendedByRemarks])
    end

    if session[:type] == "Staff"
      redirect_to :action => 'staff'
    else
      redirect_to :action => 'tele'
    end
  end

  def deleteRecord
    r = MainRecord.find_by_id(params[:id])
    r.delete
    if session[:type] == "Staff"
      redirect_to :action => 'staff'
    else
      redirect_to :action => 'tele'
    end
  end

  def loginRecord
    @login_records = LoginLog.all
  end

end
