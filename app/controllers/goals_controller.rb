class GoalsController < ApplicationController
  before_action :check_valid_goal_deletion, only: [:destroy]

  def index
    @user = User.find_by(id: params[:user_id])
    render "index"
  end

  def show
    @goal = Goal.find_by(id: params[:id])

    if @goal
      render "show"
    else
      redirect_to user_goals_url(homes_url)
    end
  end

  def destroy
    @goal.destroy
    redirect_to user_goals_path(@goal.user_id)
  end

  def create
    goal = Goal.new(goal_params)

    if goal.save
      render json: goal
    else

    end
  end

  def new
    render :new
  end

  def edit
    @goal = Goal.find_by(id: params[:id])
    render :edit
  end

  def update
    goal = Goal.find_by(id: params[:id])
    goal.update(goal_params)
    redirect_to user_goals_path(goal.user_id)
  end

  private
  def goal_params
    params.require(:goal).permit(:name, :user_id, :private_goal)
  end

  def check_valid_goal_deletion
    @goal = Goal.find_by(id: params[:id])
    render plain: "You can't delete others people goals" if current_user.id != @goal.user_id
  end
end
