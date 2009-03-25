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
    end
  end
  
  def show
    respond_to do |format|
      format.json { render :json => current_post }
    end
  end
  
  def create
    @post = Post.new(params[:post])
    
    respond_to do |format|
      if @post.save
        format.json { render :json => @post }
      else
        format.json { render :json => @post.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def update
    respond_to do |format|
      if current_post.update_attributes(params[:post])
        format.json { render :json => @post }
      else
        format.json { render :json => @post.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    respond_to do |format|
      if current_post.destroy
        format.json { render :json => @post }
      else
        format.json { render :json => @post.errors }
      end
    end
  end
  
  private
    
  def current_post
    @post ||= Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    @post = Post.new
  end
end
