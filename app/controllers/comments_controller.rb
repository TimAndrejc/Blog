class CommentsController < ApplicationController

    def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.build(comment_params)
        @comment.user = current_user
        respond_to do |format|
          if @comment.save
            format.html { redirect_to post_url(@post), notice: "Comment was successfully created." }
            format.json { render :show, status: :created, location: @post }
          else
            format.html { redirect_to post_url(@post), alert: "Comment was not created." }
            format.json { render json: @comment.errors, status: :unprocessable_entity }
          end 
        end
    end
    
    private

    def comment_params
        params.require(:comment).permit(:body)
    end
end
