class PaysController < ApplicationController
  def paySet

    @staffList = Staff.all
    @recordList = []
    @staffList2 = []
    @staffList.each do |x|
      @temp = Staffpay.where(staffid:x.id).order("created_at").last
      if @temp.nil?
        @staffList2 << x
      end
      @recordList << @temp if !@temp.nil?
    end

    @compiledList = @staffList2 | @recordList

    @newPay = Staffpay.new

  end

  def addPay
    Staffpay.create(staffPay_params)
    redirect_to :action => 'paySet'
  end

  def staffPay_params
    params.require(:staffpay).permit!
  end
end
