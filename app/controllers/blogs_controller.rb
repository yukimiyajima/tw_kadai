class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]  
 
  def index
    @blogs = Blog.all
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    if params[:back]
      render :new
    elsif @blog.save
      redirect_to blogs_path, notice: "新規投稿しました！"
    else
      render :new
    end
  end

  def show
    @blog = Blog.find(params[:id])  
  end

  def edit
    @blog = Blog.find(params[:id]) 
  end

  def confirm
    @blog = Blog.new(blog_params)
    render :new if @blog.invalid?
  end

  def destroy
    @blog.destroy
    redirect_to blogs_path, notice:"投稿を削除しました！"
  end

  def update
    @blog = Blog.find(params[:id])  
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: "内容を編集しました！"
    else
      render :edit
    end
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :content)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end
end