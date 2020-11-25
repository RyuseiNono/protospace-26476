class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index,:show]


  def index
    @prototypes=Prototype.includes(:user).order("created_at DESC")
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to url: root_path
    else
      render action: :new
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments= @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
    user_can_edit?
  end

  def update
    @prototype = Prototype.find(params[:id])
    user_can_edit?
    if @prototype.update(prototype_params)
      redirect_to url: prototype_path(@prototype.id)
    else
      render action: :edit
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    user_can_edit?
    @prototype.destroy
    redirect_to action: :index
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title,:catch_copy,:concept,:image).merge(user_id:current_user.id)
  end

  # 編集権限がない場合、詳細ページへリダイレクトする
  def user_can_edit?
    redirect_to action: :index unless @prototype.user_id == current_user.id
  end
end
