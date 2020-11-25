class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    comment = Comment.new(comment_params)
    if comment.save
      redirect_to  prototype_path(comment.prototype)
    else
      @prototype = comment.prototype
      @comment = comment
      render "prototypes/show"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
