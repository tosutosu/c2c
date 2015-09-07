class SessionsController < ApplicationController
  def new
  end
  
  def create
    #binding.pry
    # メールアドレスでユーザーを検索
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      #flash[:info] = "logged in as #{@user.name}"
      redirect_to @user
    else
      ##TODO flashを有効にするには "views/layouts/application.html.erb" を編集する
      flash[:danger] = 'invalid email/password combination' #現在反映されない
      render 'new'
    end
    
    def destroy
       # sessionにのuser_idを空にすると
       # サーバーとブラウザの両方でセッション情報が破棄される
      session[:user_id] = nil
      redirect_to root_path
    end
  end
end
