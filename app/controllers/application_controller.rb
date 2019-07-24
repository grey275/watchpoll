class ApplicationController < ActionController::API
  def fallback_index_html
    puts 'rendering fallback'
    render :file => 'public'
  end
 end
