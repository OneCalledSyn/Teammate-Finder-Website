class Users::RegistrationsController < Devise::RegistrationsController
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
end