class OrdersController < ApplicationController
 
  def index
 	  authenticate_admin!
 	  @orders = Order.all
  end

  def new
  	@temp_job = session[:temp_job]	
  	puts 'second test'
  	puts @temp_job
  end

end
