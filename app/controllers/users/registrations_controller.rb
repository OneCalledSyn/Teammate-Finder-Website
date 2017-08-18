class Users::RegistrationsController < Devise::RegistrationsController
  before_action :select_plan, only: :new
  
  # Extend default Devise gem behavior 
  # so users signing up with pro account
  # save with a special Stripe subscription function.
  # Otherwise, user signed up normally.
  def create
    super do |resource|
      if params[:plan]
        resource.plan_id = params[:plan]
        if resource.plan_id == 2
          resource.save_with_subscription
        else 
          resource.save
        end
      end
    end
  end
  
  private
    def select_plan
      flash[:notice] = "Please select a membership to sign up."
      unless (params[:plan] == '1' || params[:plan] == '2')
        redirect_to root_url
      end
    end
end