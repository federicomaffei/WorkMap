class ChargesController < ApplicationController


def new
  @job = Job.find(params[:job_id])
end

def create
  # Amount in cents
  # puts session[:temp_job]

  @job = Job.find(params[:job_id])
# working out how to create a new order object with a successful charge here.
  # @order = Order.create()
  @amount = 500

  customer = Stripe::Customer.create(
    :email => 'example@stripe.com',
    :card  => params[:stripeToken]
  )

  charge = Stripe::Charge.create(
    :customer    => customer.id,
    :amount      => @amount,
    :description => 'Rails Stripe customer',
    :currency    => 'gbp'
  )

  @job.paid = true
  @job.save
  Order.create(employer: current_employer, job: @job)

flash[:notice] = "Thanks fo your payment of #{@amount}"
redirect_to "/employers/#{current_employer.id}/adverts"

rescue Stripe::CardError => e
  flash[:error] = e.message
  redirect_to new_job_charge_path(@job)
end

end
