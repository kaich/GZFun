class ActivitiesController < ApplicationController

    before_action :authenticate_user! , only: [:new , :destroy , :edit , :favorite, :create_comment]

    include ActivitiesHelper

    def index
      @activities = Activity.search_by("name",params[:search]).paginate(:page => params[:page], :per_page => 20)
    
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render xml: @activities }
      end
    end


    def new
        @activity = Activity.new
    end

    def create
        @activity = Activity.new(activity_params)
        
        respond_to do |wants|
            if @activity.save
                flash[:success] = 'Activity was successfully created.'
                wants.html { redirect_to(@activity) }
                wants.xml { render :xml => @activity, :status => :created, :location => @activity }
            else
                flash[:danger] = 'Activity was failed created.'
                wants.html { render :action => "new" }
                wants.xml { render :xml => @activity.errors, :status => :unprocessable_entity }
            end
        end
    end


    def show
        @activity = Activity.find(params[:id])
        @comments = @activity.comments.recent.limit(30).all
    
        respond_to do |format|
            format.html # show.html.erb
            format.xml  { render xml: @activity }
        end
    end

    def edit
      @activity = Activity.find(params[:id])
    end


    def update
      @activity = Activity.find(params[:id])
    
      respond_to do |format|
        if @activity.update(activity_params)
          flash[:notice] = 'Activity was successfully updated.'
          format.html { redirect_to(@activity) }
          format.xml  { head :ok }
        else
          format.html { render action: 'edit' }
          format.xml  { render xml: @activity.errors, status: :unprocessable_entity }
        end
      end
    end


    def destroy
      @activity = Activity.find(params[:id])
      @activity.destroy
    
      respond_to do |format|
        format.html { redirect_to(activities_url) }
        format.xml  { head :ok }
      end
    end


    def favorite 
        @activity = Activity.find(params[:id])

        @isfavorite = favorite? @activity
        if @isfavorite 
            current_user.dislikes @activity                
            @isfavorite = false
        else
            current_user.likes @activity
            @isfavorite = true
        end
    end


    def create_comment 
      @commentable = Activity.find(params[:id])
      @comment = @commentable.comments.create
      @comment.comment = params[:content]
      @comment.user = current_user
      @comment.save
    end


    private

    def activity_params 
        params.require(:activity).permit(:name,:cover,:start_time,:end_time,:rule,:information) 
    end

end
