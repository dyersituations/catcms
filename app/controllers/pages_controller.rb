class PagesController < ApplicationController
  before_filter :authorize, :except => :show

  def new
    @page = Page.new
  end

  def show
    load_page
    @pages = Page.all

    # render appropriate view
    case @page.page_type
    when Page::PAGETYPES[:BLOG]
      @posts = Post.where('posts.page_path=?', @page.path)
      @view = 'posts/blog'
    end
  end

  def edit
    load_page
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
    load_page
    
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
    load_page
    @page.destroy

    respond_to do |format|
      format.html { redirect_to root_path }
    end
  end
  
  private
  
  def load_page
    if params[:path]
      @page = Page.find_by_path!(params[:path])
    else
      @page = Page.find_by_id!(params[:id])
    end
  end
end
