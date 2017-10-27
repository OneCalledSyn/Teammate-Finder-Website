class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :only_current_user
  
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
      redirect_to user_path(id: params[:user_id] )
    else
      render action: :new
    end
  end
  
  # GET to /users/:user_id/profile/edit
  def edit
    @user = User.find(params[:user_id])
    @profile = @user.profile
  end
  
  # PUT/PATCH to /users/:user_id/profile
  def update
    # Retrieve user from database
    @user = User.find(params[:user_id])
    # Retrieve user's profile
    @profile = @user.profile
    # Mass assign edited profile attributes and save any updates
    if @profile.update_attributes(profile_params)
      flash[:success] = "Profile updated!"
      #Redirect user back to their profile page
      redirect_to user_path(id: params[:user_id])
    else
      render action: :edit
    end
  end
  
  private
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :avatar, :summoner_name, :main_role, :secondary_role, :solo_rank, :flex_rank, :phone_number, :email_address, :description)
    end
    
    def only_current_user
      @user = User.find(params[:user_id])
      redirect_to (root_url) unless @user == current_user
      if @user != current_user
        then flash[:success] = "Trying to edit other users' profiles, are we? Surely you've been raised better than that..." 
      end
    end
end