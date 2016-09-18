class PostsController < ApplicationController
  before_filter :authorize, :except => :show
  before_filter :load_pages, :only => [:show, :new, :edit]

  def index
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(post_params)
        format.html { redirect_to request.referer, notice: 'Successfully updated.' }
      else
        format.html { redirect_to request.referer, notice: 'Updated not successful.' }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.destroy
        format.html { redirect_to request.referer, notice: 'Successfully removed.' }
      else
        format.html { redirect_to request.referer, notice: 'Remove not successful.' }
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, :image, :title, :page_path, :category)
  end
end
