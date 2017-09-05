class ProfilesController < ApplicationController
  
  # GET to /users/:user_id/profile/new
  def new
    #Render blank profile details form
    @profile = Profile.new
  end
  
  # POST to /users/:user_id/profile
  def create
    # Ensure have user that is filling out form
    @user = User.find(params[:user_id])
    # Create profile linked to specific user
    @profile = @user.build_profile(profile_params)
    if @profile.save
      flash[:success] = "Profile updated!"
      redirect_to user_path( params[:user_id] )
    else
      render action: :new
    end
  end
  
  private
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :summoner_name, :main_role, :secondary_role, :solo_rank, :flex_rank, :phone_number, :email_address, :description)
    end
end