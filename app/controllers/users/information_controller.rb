class Users::InformationController < ApplicationController
  before_action :judge_userown , only: [:update,:edit]

  def edit
    @user = current_user 
  end

  def update
    @user =  current_user
  
    respond_to do |format|
      if @user.update(user_params)
        flash[:success] = t(:update_user_information_success)
        format.html { render action: 'edit' }
        format.xml  { head :ok }
      else
        format.html { render action: 'edit' }
        format.xml  { render xml: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @user = User.find(params[:id])
  
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render xml: @user }
    end
  end


  def favorite_activity 
    @activities = current_user.get_voted(Activity) 
  end


  def favorite_bike 
    @bikes = current_user.get_voted(Bike)  
  end

  private 

  def user_params
    params.require(:user).permit(:nick,:sex,:birthday,:home_address,:qq_number,:phone,:signature,:intro,:avatar,:avatar_cache) 
  end

  def judge_userown 
    if current_user  != User.find_by_id(params[:id])  
      redirect_to root_path
    end
  end
end
