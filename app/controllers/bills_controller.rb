class BillsController < ApplicationController
  before_filter :find_bill, :except => [:index, :new, :create]
  before_filter :require_user

  def index
    if params[:search].blank?
      # TODO: filter deleted bills
      @bills = @user.bills.group_by { |b| b.state }
    else
      # TODO: only show user's bills
      @bills = Bill.find(:all, :conditions => ["title LIKE ? AND state != 10", '%' + params[:search] + '%']).group_by { |b| b.state }
    end
  end

  def show
    @company = @user.company
  end
  
  def new
    @bill = Bill.new
  end
  
  def create
    @bill = Bill.new(params[:bill])
    @bill.state = 0
    @bill.user = current_user
    if @bill.save
      flash[:notice] = 'Bill successfully created.'
      redirect_to @bill
    else
      render :action =>"new"
    end
  end
  
  def close
    @bill.state = @bill.state + 1
    # set billed_date if bill is being marked as billed
    @bill.billed_date = Date.today if @bill.state == 1
    # skip admonished state
    @bill.state = @bill.state + 1 if @bill.state == 2
    #set paid date if bill is being marked as paid
    @bill.paid_date = Date.today if @bill.state == 3

    if @bill.save
      flash[:notice] = 'Bill successfully closed.'
    else
      flash[:notice] = 'There was an error saving the bill!'
    end
    redirect_to @bill
  end

  def admonish
    @bill.state = 2
    if @bill.first_admonishion_date.nil?
      @bill.first_admonishion_date = Date.today
    else
      @bill.second_admonishion_date = Date.today
    end
    @position = Position.new(:count => 1, :price => 3, :tax => 19, :title => "Admonishion fee")
    @bill.positions << @position
    if @bill.save
      redirect_to @bill
    else
      flash[:notice] = error_messages_for :bill
      redirect_to @bill
    end
  end
  
  def edit
  end

  def update
    if @bill.update_attributes(params[:bill])
      flash[:notice] = 'Bill successfully updated.'
      redirect_to :action => "show", :id => params[:id]
    else
      render :action => "edit"
    end
  end

  def destroy
    if @bill.update_attribute(:state, 10)
      flash[:notice] = 'Bill successfully destroyed.'
    else
      flash[:notice] = 'There was an error destroying the Bill!'
    end
    redirect_to :action => "index"
  end
  
  private
  
  def find_bill
    @bill = Bill.find_by_id(params[:id])
  end
  
end
