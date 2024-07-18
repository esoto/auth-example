class LoginsController < ApplicationController
  def show
    user = User.find_by_token_for(:magic_link, params[:token])
    login(user) if user
    redirect_to root_path
  end

  def new
  end

  def create
    if user = User.find_by_email(params[:email])
      LoginMailer.with(
        user: user,
        token: user.generate_token_for(:magic_link)
      ).magic_link.deliver_later
    end
    redirect_to root_path, notice: "Check your email for the magic link"
  end
end