class GoalCommentsController < ApplicationController
  def create
    comment = GoalComment.new(comment_params)
    comment.goal_id = params[:goal_id]
    comment.commenter_id = current_user.id

    comment.save

    redirect_to goal_url(comment.goal_id)

  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end
end
