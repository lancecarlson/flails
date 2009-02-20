class PostsController < ApplicationController
  before_filter :find_post, :except => :index
  
  def index
    @posts = Post.find(:all, :limit => 10)
    
    respond_to do |format|
      format.json { render :json => @posts.to_json }
    end
  end
  
  def show
    respond_to do |format|
      format.json { render :json => @post.to_json }
    end
  end
  
  def create
  end
  
  def update
  end
  
  def destroy
  end
  
  private
    
    def find_post
      @post = Post.find(params[:id])
    end
end
