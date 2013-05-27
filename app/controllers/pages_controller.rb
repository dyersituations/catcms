class PagesController < ApplicationController
  before_filter :authorize, :except => :show
  before_filter :load_page, :except => :create
  before_filter :load_pages, :only => [:show, :new, :edit]

  def show
    # Find appropriate partial view
    case @page.page_type
    when Page::PAGETYPES[:BLOG]
      load_posts_desc
      @view = 'layouts/blog'
    when Page::PAGETYPES[:GALLERY]
      load_posts_alpha
      @view = 'layouts/gallery'
    end
  end

  def create
    @page = Page.new(params[:page])

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
    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { 
          redirect_to page_view_path(@page.path), 
          notice: 'Page was successfully updated.' 
        }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @page.destroy

    respond_to do |format|
      format.html { redirect_to root_path }
    end
  end
  
  private
  
  # Load current page
  def load_page
    if params[:path]
      @page = Page.find_by_path!(params[:path])
    elsif params[:id]
      @page = Page.find_by_id!(params[:id])
    else
      @page = Page.new
    end
  end
  
  # Load pages alphabetically
  def load_posts_alpha
    @posts = Post.where('posts.page_path=?', @page.path)
        .order('title ASC')
  end
  
  # Load posts newest first
  def load_posts_desc
    @posts = Post.where('posts.page_path=?', @page.path)
        .order('created_at DESC')
  end
end
