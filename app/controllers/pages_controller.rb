class PagesController < ApplicationController
  def show
    load_page
    @pages = Page.all
  end

  def edit
    load_page
  end

  def update
    load_page
    
    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
  
  def load_page
    @page = Page.find_by_path!(params[:path])
  end
end
