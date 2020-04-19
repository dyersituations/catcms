class PostsController < ApplicationController
  def new
    @post = Post.new
    respond_to do |format|
      format.html
      format.json { render json: @post }
    end
  end

  def create
    @post = Post.new(post_params)
    add_thumbnail
    respond_to do |format|
      if @post.save
        page = Page.find(@post.page_id)
        format.html { redirect_to root_path + URI.encode(page.path), notice: "Post was successfully created." }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @post = Post.find(params[:id])
    add_thumbnail
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to request.referer, notice: "Successfully updated." }
      else
        format.html { redirect_to request.referer, notice: "Updated not successful." }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.destroy
        format.html { redirect_to request.referer, notice: "Successfully removed." }
      else
        format.html { redirect_to request.referer, notice: "Remove not successful." }
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, :image, :title, :category, :page_id)
  end

  def add_thumbnail
    if post_params[:image]
      @post.thumbnail = File.open(post_params[:image].tempfile)
    end
  end
end
