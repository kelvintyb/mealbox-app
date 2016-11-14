class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
before_filter :set_cuisine

  def set_cuisine
    @header_cuisine_list = ['Malay', 'Indian', 'Chinese', 'Western']
  end

end
