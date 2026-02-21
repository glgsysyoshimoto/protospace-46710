class CommentsController < ApplicationController

  # def create
  #   Comment.create(comment_params)
  # end

  # private
  # def comment_params
  #   params.require(:comment).permit(:text).merge(user_id: current_user.id, tweet_id: params[:tweet_id])
  # end

  def create
    # Comment.create(comment_params)
    # comment = Comment.new(comment_params)
    # if comment.save
    #   redirect_to prototype_path(comment.prototype_id)
    # end   
    comment = Comment.create(comment_params)
      #redirect_to "/prototypes/#{comment.prototype.id}"     
    if comment.persisted?
      redirect_to "/prototypes/#{comment.prototype.id}"
    else
      # render "prototypes/show"
      @prototype = Prototype.find(params[:prototype_id])
      @comment = comment
      @comments = @prototype.comments.includes(:user)
      render "prototypes/show"
    end
  end
  
  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end


end
