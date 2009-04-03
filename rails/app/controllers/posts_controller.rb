class PostsController < ApplicationController
  
  def reset
    Post.delete_all

    p1 = Post.new(:subject => 'testFindAll #1', :body => 'testFindAll #1 body')
    p1.id = 1
    p1.save!

    p2 = Post.new(:subject => 'testFindAll #2', :body => 'testFindAll #2 body')
    p2.id = 2
    p2.save!

    render :nothing => true
  end
  
  def index
    @posts = Post.find(:all, :limit => 10)
    
    respond_to do |format|
      format.json { render :json => @posts }
      format.amf { render :amf => @posts }
    end
  end
  
  def show
    begin
      @post = Post.find(params[:id])
    rescue ActiveRecord::RecordNotFound 
      @post = FaultObject.new("Record Not Found")
    end
    
    respond_to do |format|
      format.json { render :json => @post }
      format.amf { render :amf => @post }
    end
  end
  
  def create
    @post = Post.new(params[:post])
    @post = FaultObject.new(@post.errors) if !@post.save
    
    respond_to do |format|
      format.json { render :json => @post }
      format.amf { render :amf => @post }
    end
  end
  
  def update
    begin
      @post = Post.find(params[:id])
      @post = FaultObject.new(@post.errors) if !@post.update_attributes(params[:post])
    rescue ActiveRecord::RecordNotFound
      @post = FaultObject.new("Record Not Found")
    end
    
    respond_to do |format|
      format.json { render :json => @post }
      format.amf { render :amf => @post }
    end
  end
  
  def destroy
    begin
      @post = Post.find(params[:id])
      @post = FaultObject.new(@post.errors) if !@post.destroy
    rescue ActiveRecord::RecordNotFound
      @post = FaultObject.new("Record Not Found")
    end
    
    respond_to do |format|
      format.json { render :json => @post }
      format.amf { render :amf => @post }
    end
  end
end
