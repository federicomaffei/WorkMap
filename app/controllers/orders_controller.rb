class OrdersController < ApplicationController
 
 def index
 	authenticate_admin!
 end

end
