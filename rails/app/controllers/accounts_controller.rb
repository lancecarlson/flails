class AccountsController < ApplicationController
  
  before_filter :find_account, :except => [:index, :create]
  
  def index
    @accounts = Account.find(:all, :limit => 10)
    
    respond_to do |format|
      format.json { render :json => @accounts }
    end
  end

  def show
    respond_to do |format|
      format.json { render :json => @account }
    end
  end

  def create
    @account = Account.new(params[:account])
    
    respond_to do |format|
      if @account.save
        format.json { render :json => @account, :status => :created, :location => @account }
      else
        format.json { render :json => @account.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @account.update_attributes(params[:account])
        format.json  { head :ok }
      else
        format.json  { render :json => @account.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @account.destroy

    respond_to do |format|
      format.json  { head :ok }
    end
  end
  
  private
    
    def find_account
      @account = Account.find(params[:id])
    end
end
