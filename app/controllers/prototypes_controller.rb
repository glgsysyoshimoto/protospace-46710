class PrototypesController < ApplicationController
  #  before_action :authenticate_user!
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  #  必要があります。only オプションを指定しないと全てのアクションにログインが必要になってしまい、ログインしていないユーザーが index や show ページも見られなくなってしまいます。
  #  今回は new, create, edit, update, destroy のみログインを必須にしたいので only オプションで指定する必要があります。
  before_action :set_prototype, only: [:edit, :update, :destroy, :show]
  before_action :move_to_index, only: [:edit, :update, :destroy]

  def index
    # @tweets = Tweet.all
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    #Prototype.create(prototype_params)    
    # redirect_to '/' 

    if @prototype.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # @prototype = Prototype.find(params[:id])
  end

  # def update
  #   tweet = Tweet.find(params[:id])
  #   tweet.update(tweet_params)
  #   redirect_to root_path
  # end

  # def update
  #   prototype = Prototype.find(params[:id])
  #   prototype.update(prototype_params)
  #   redirect_to prototype_path(prototype)
  # end

  def update
    @prototype = Prototype.find(params[:id])
    
    if @prototype.update(prototype_params)
      # 更新成功 → 詳細画面へ
      redirect_to prototype_path(@prototype)
    else
      # 更新失敗 → 編集画面を再表示
      render :edit
    end  
  end


  # def destroy
  #   tweet = Tweet.find(params[:id])
  #   tweet.destroy
  #   redirect_to root_path
  # end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end



  # prototypesコントローラーにshowアクションを設定した（まだアクション内の処理は書かない）
  # showアクションにインスタンス変数@prototypeを定義した。且つ、Pathパラメータで送信されるID値で、
  # Prototypeモデルの特定のオブジェクトを取得するように記述し、それを@prototypeに代入した
  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
    #必要かどうか不明のためコメントアウトしておく。
    #@comments = @prototype.comments.includes(:user)
  end

private

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def move_to_index
    redirect_to root_path if current_user != @prototype.user
  end

  def prototype_params
    #https://master.tech-camp.in/v2/curriculums/8103
    #画像の保存を許可するストロングパラメーターにしましょう
    #params.require(:message).permit(:content, :image).merge(user_id: current_user.id)

    params.require(:prototype).permit(
      :title,
      :catch_copy,
      :concept,
      :image
    ).merge(user_id: current_user.id)
  end

end
