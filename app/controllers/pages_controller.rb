class PagesController < ApplicationController
  before_action :authorize, :except => :show
  before_action :load_page
  before_action :plain, :only => [:new, :edit]
  after_action -> { flash.discard }

  def show
    case @page.page_type
    when Page::PAGETYPES[:BLOG]
      load_posts_desc
      @view = "layouts/blog"
    when Page::PAGETYPES[:GALLERY]
      load_posts_alpha
      @view = "layouts/gallery"
    else
      @view = "layouts/plain"
    end
  end

  def new
    @page = Page.new
  end

  def create
    save_page
  end

  def update
    save_page
  end

  def destroy
    Page.find_by_id(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to root_path }
    end
  end

  def edit_posts
    @posts = Post.where("posts.page_id=?", @page.id).order("title ASC")
  end

  private

  def page_params
    page = params[:page]
    if !page.nil?
      page.permit(:path, :page_type, :banner, :content)
    end
  end

  def plain
    @plain = @page == nil || @page.page_type == Page::PAGETYPES[:PLAIN]
  end

  def load_page
    if params[:id]
      # Id means the page is edited.
      @page = Page.find_by_id(params[:id])
    elsif params[:path]
      # Path means the page is shown.
      @page = Page.where("lower(pages.path)=?", params[:path].downcase).first
    elsif !page_params.nil?
      # Page not nil when failing to save new page.
      @page = Page.new(page_params)
    elsif !Page.any? && action_name != "new"
      redirect_to admin_path
    else
      # When loading root.
      @page = Page.first
    end
  end

  def load_posts_alpha
    @posts = Post.where("posts.page_id=?", @page.id)
    @cats = @posts.order("category ASC").pluck(:category)
    if @posts.count > 0
      cat = params[:category]
      if cat == nil
        cat = @cats.uniq.sort.first
      end
      @posts = @posts.where("lower(posts.category)=?", cat.downcase).order("title ASC")
    else
      @posts = []
    end
  end

  def load_posts_desc
    @posts = Post.where("posts.page_id=?", @page.id).order("created_at DESC")
  end

  def save_page
    error_message = "Error saving page. Unique path is required. Please choose banner again if needed."
    updated_params = params[:page].permit(:path, :page_type, :banner, :content)
    begin
      updated_params.require(:path)
    rescue ActionController::ParameterMissing
      flash[:notice] = error_message
      render :edit
      return
    end
    if params[:id]
      @page = Page.find_by_id(params[:id])
    else
      @page = Page.new(updated_params)
    end
    # Page content not needed for GALLERY or BLOG.
    if @page.page_type == Page::PAGETYPES[:GALLERY] || @page.page_type == Page::PAGETYPES[:BLOG]
      @page.content = ""
    end
    begin
      if params[:id]
        success = @page.update(updated_params)
      else
        success = @page.save
      end
    rescue ActiveRecord::RecordNotUnique => e
      flash[:notice] = error_message
      render :new
      return
    end
    if success
      respond_to do |format|
        format.html { redirect_to page_view_path(@page.path) }
      end
    else
      flash[:notice] = error_message
      render :new
    end
  end
end
