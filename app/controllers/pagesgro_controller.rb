class PagesgroController < ApplicationController
  def tele
    id = session[:user]
    @records = MainRecordGro.where(apptBy:id)
    @new_record = MainRecordGro.new
  end

  def staff
    id = session[:user]
    @records1 = MainRecordGro.where(apptBy:id)
    @records2 = MainRecordGro.where(attendedBy:id)
    @records = @records1 + @records2
    @records = @records.uniq
    @new_record = MainRecordGro.new
    @staff = Staff.where(profession:"staff")
  end

  def company
    # p params[:selections]
    # p params[:startdate]
    # p params[:enddate]
    if params[:selections].nil? && (params[:startdate]=="" || params[:enddate]=="" || params[:startdate].nil? || params[:enddate].nil? )
      @records = MainRecordGro.all
    else
      if !params[:selections].nil?
        gradearray = params[:selections]
        @records1 = []
        gradearray.each do |g|
          @records1 = @records1 + MainRecordGro.where(attendedByGrade:g)
        end
      end
      if (params[:startdate]!="") && (params[:enddate]!="")
        sd = params[:startdate].to_date
        ed = params[:enddate].to_date
        @records2 = MainRecordGro.where(:dateAppt => sd.beginning_of_day..ed.end_of_day)
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

    @staff = Staff.where(profession:"staff", company:"groventure")
    @telemarketers = Staff.where(profession:"tele", company:"groventure")
  end

  def overall
    @records = MainRecordGro.all
  end

  def add
    r = MainRecordGro.new
    r.companyName = params[:main_record_gro][:companyName]
    r.address = params[:main_record_gro][:address]
    r.postalCode = params[:main_record_gro][:postalCode]
    r.contactPerson = params[:main_record_gro][:contactPerson]
    r.position = params[:main_record_gro][:position]
    r.hp = params[:main_record_gro][:hp]
    r.office = params[:main_record_gro][:office]
    r.email = params[:main_record_gro][:email]
    r.apptBy = session[:user]
    r.dateAppt = params[:main_record_gro][:dateAppt]
    r.remarks = params[:main_record_gro][:remarks]
    r.attendedBy = params[:main_record_gro][:attendedBy]
    r.attendedByGrade = params[:main_record_gro][:attendedByGrade]
    r.attendedByRemarks = params[:main_record_gro][:attendedByRemarks]
    r.save
    if session[:type]=="Telemarketer"
      redirect_to :action => 'tele'
    elsif session[:type]=="Staff"
      redirect_to :action => 'staff'

    end

  end

  def update
    m = MainRecordGro.find_by_id(params[:id])
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
    t = Staff.find_by(staffid:userid, profession:"tele", company: "groventure")
    s = Staff.find_by(staffid:userid, profession:"staff", company: "groventure")
    if !t.nil?

      if pass != t.password
        flash[:error] = "Wrong password!"
        redirect_to :action => 'loginPage'
      else
        session[:user] = userid

        session[:type] = "Telemarketer"
        session[:company] = 'groventure'
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
        session[:company] = 'groventure'
        LoginLog.create(:userid => userid, :logintime => DateTime.current)
        redirect_to :action => 'staff'
      end

    elsif userid == "master"
      if pass != "master"
        flash[:error] = "Wrong password!"
        redirect_to :action => 'loginPage'
      else
        session[:user] = userid
        session[:type] = "Master"
        session[:company] = 'groventure'
        LoginLog.create(:userid => userid, :logintime => DateTime.current)
        redirect_to :action => 'company'
      end

    else
      redirect_to :action => 'overall'
    end
  end

  def logout
    session[:user]=nil
    session[:type]=nil
    session[:company] = nil
    redirect_to :action => 'loginPage'
  end

  def edit
    type = params[:type]
    id = params[:id]
    if type == "staff"
      @new_staff = Staff.find_by_id(id)
      @type = 'staff'
    else
      @new_staff = Staff.find_by_id(id)
      @type = 'telemarketer'
    end
  end

  def edit2
    if params[:type] == 'staff'
     
      new_staff = Staff.find_by_id(params[:staff][:id])
      # new_staff.update_attribute(:staffid, params[:staff][:staffid])
      new_staff.update_attribute(:password, params[:staff][:password])
       new_staff.update_attribute(:dateemployed, params[:staff][:dateemployed])
    else
      new_staff = Staff.find_by_id(params[:staff][:id])
      # new_staff.update_attribute(:staffid, params[:staff][:staffid])
      new_staff.update_attribute(:password, params[:staff][:password])
       new_staff.update_attribute(:dateemployed, params[:staff][:dateemployed])
    end
    redirect_to :action => 'company'

  end

  def delete
    if params[:type] == 'staff'
      s = Staff.find_by_id(params[:id])
    s.delete
    else
      s = Staff.find_by_id(params[:id])
    s.delete
    end
    redirect_to :action => 'company'
  end

 

  def editRecord
    @new_record = MainRecordGro.find_by_id(params[:id])
    @staff = Staff.where(profession:"staff")
  end

  def editRecord2
    r = MainRecordGro.find_by_id(params[:main_record_gro][:id])
    # r.update_attributes(:companyName => params[:main_record_gro][:companyName],:address => params [:main_record_gro][:address],:postalCode => params[:main_record_gro][:postalCode],:contactPerson => params[:main_record_gro][:contactPerson],:position => params[:main_record_gro][:position],:hp => params[:main_record_gro][:hp],:office => params[:main_record_gro][:office],:email =>params [:main_record_gro][:email],:dateAppt => params[:main_record_gro][:dateAppt],:remarks => params[:main_record_gro][:remarks])
    r.update_attributes(:companyName=>params[:main_record_gro][:companyName],:address=>params[:main_record_gro][:address],:postalCode=>params[:main_record_gro][:postalCode],:contactPerson=>params[:main_record_gro][:contactPerson],:position=>params[:main_record_gro][:position],:hp=>params[:main_record_gro][:hp],:office=>params[:main_record_gro][:office],:email=>params[:main_record_gro][:email],:dateAppt=>params[:main_record_gro][:dateAppt],:remarks=>params[:main_record_gro][:remarks])
    if session[:type]=='Staff'
      r.update_attributes(:attendedBy =>params[:main_record_gro][:attendedBy],:attendedByGrade =>params[:main_record_gro][:attendedByGrade],:attendedByRemarks =>params[:main_record_gro][:attendedByRemarks])
    end

    if session[:type] == "Staff"
      redirect_to :action => 'staff'
    else
      redirect_to :action => 'tele'
    end
  end

  def deleteRecord
    r = MainRecordGro.find_by_id(params[:id])
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
