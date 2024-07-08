class ApplicationController < ActionController::Base
    helper_method :current_cart
  
    private
  
    def current_cart
      @current_cart ||= Cart.find_or_create_by(user_id: current_user.id)
    end
end
  