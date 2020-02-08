class PagesController < ApplicationController
  before_action :authorize, :except => :show
  before_action :load_page, :only => [:show, :edit, :edit_posts]
  before_action :load_pages, :only => [:show, :new, :edit, :edit_posts]
  before_action :plain, :only => [:new, :edit]

  def show
    case @page.page_type
      when Page::PAGETYPES[:HOME]
        @view = 'layouts/home'
      when Page::PAGETYPES[:BLOG]
        load_posts_desc
        @view = 'layouts/blog'
      when Page::PAGETYPES[:GALLERY]
        load_posts_alpha
        @view = 'layouts/gallery'
      else
        @view = 'layouts/plain'
    end
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(page_params)
    if @page.page_type == Page::PAGETYPES[:GALLERY]
      @page.content = ''
    end
    respond_to do |format|
      if @page.save
        format.html {
          redirect_to page_view_path(@page.path),
                      notice: 'Page was successfully created.'
        }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    page = Page.find_by_id(params[:id])
    respond_to do |format|
      if page.update_attributes(page_params)
        format.html { redirect_to page_view_path(page.path) }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    Page.find_by_id(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to root_path }
    end
  end

  def edit_posts
    @posts = Post.where('posts.page_id=?', @page.id).order('title ASC')
  end

  private

  def page_params
    params.require(:page).permit(:page_type, :banner, :path, :content)
  end

  def plain
    @plain = @page == nil || @page.page_type == Page::PAGETYPES[:PLAIN]
  end

  def load_page
    if !Page.any?
      redirect_to new_page_path
    else
      # Id means the page is edited.
      # Path means the page is shown.
      id = params[:id]
      path = params[:path]
      if id
        @page = Page.find_by_id(id)
      elsif path
        @page = Page.find_by_path(path)
      else
        @page = Page.first
      end
    end
  end

  def load_posts_alpha
    @posts = Post.where('posts.page_id=?', @page.id)
    @cats = @posts.order('category ASC').pluck(:category)
    if @posts.count > 0
      cat = params[:category]
      if cat == nil
        cat = @cats.uniq.sort.first
      end
      @posts = @posts.where('posts.category=?', cat).order('title ASC')
    else
      @posts = []
    end
  end

  def load_posts_desc
    @posts = Post.where('posts.page_id=?', @page.id).order('created_at DESC')
  end
end
