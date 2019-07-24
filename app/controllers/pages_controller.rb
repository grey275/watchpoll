class PagesController < ApplicationController
  def home
    puts 'rendering home'
    render :file => 'public'
  end
end
