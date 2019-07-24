class PagesController < ActionController::Base
  def index
    puts 'rendering pages index'
    render :file => 'public/index.html'
  end
end
