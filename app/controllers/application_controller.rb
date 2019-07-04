class ApplicationController < ActionController::API
  def fallback_index_html
    render :file => 'client/build'
  end
 end
