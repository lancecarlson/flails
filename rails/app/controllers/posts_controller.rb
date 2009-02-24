class PostsController < ApplicationController
  before_filter :find_post, :except => [:index, :create]
  
  def index
    @posts = Post.find(:all, :limit => 10)
    
    respond_to do |format|
      format.json { render :json => @posts }
    end
  end
  
  def show
    respond_to do |format|
      format.json { render :json => @post }
    end
  end
  
  def create
    @post = Post.new(params[:post])
    
    respond_to do |format|
      if @post.save
        format.json { render :json => @post, :status => :created, :location => @account }
      else
        format.json { render :json => @post.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def update
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.json { head :ok }
      else
        format.json { render :json => @post.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    respond_to do |format|
      if @post.destroy
        format.json { head :ok }
      else
        format.json { render :json => @post.errors }
      end
    end
  end
  
  private
    
    def find_post
      @post = Post.find(params[:id])
    end
end
