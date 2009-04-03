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
    respond_to do |format|
      if current_post.is_a?(Post)
        format.json { render :json => current_post }
        format.amf { render :amf => current_post }
      else        
        format.json { render :json => current_post.errors }
        format.amf { render :amf => current_post.errors }
      end
    end
  end
  
  def create
    @post = Post.new(params[:post])
    
    respond_to do |format|
      if @post.save
        format.json { render :json => @post }
        format.amf { render :amf => @post }
      else
        format.json { render :json => @post.errors }
        format.amf { render :amf => @post.errors }
      end
    end
  end
  
  def update
    respond_to do |format|
      if current_post.is_a?(Post) && current_post.update_attributes(params[:post])
        format.json { render :json => @post }
        format.amf { render :amf => @post }
      else
        format.json { render :json => @post.errors }
        format.amf { render :amf => @post.errors }
      end
    end
  end
  
  def destroy
    respond_to do |format|
      if current_post.destroy
        format.json { render :json => @post }
        format.amf { render :amf => @post }
      else
        format.json { render :json => @post.errors }
        format.amf { render :amf => @post.errors }
      end
    end
  end
  
  private
    
  def current_post
    @post ||= Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    logger.info("Can't find record")
    @post = Object.new
    def @post.errors
      FaultObject.new(:message => "Can't find record")
    end
  end
end
