class OrdersController < ApplicationController

  def index
 	  authenticate_admin!
 	  @orders = Order.all
  end

  # def new
  # 	@temp_job = session[:temp_job]	
  # 	puts 'second test'
  # 	puts @temp_job
  # end

# need to create a new order action here, what to put in it?
  
  def new
  	@order = order
  end

end
