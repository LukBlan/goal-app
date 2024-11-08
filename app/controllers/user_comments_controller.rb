class UserCommentsController < ApplicationController
  def create
    comment = UserComment.new(comment_params)
    comment.user_id = params[:user_id]
    comment.commenter_id = current_user.id
    comment.save
    redirect_to user_url(comment.user_id)
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end
end
