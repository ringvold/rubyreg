# encoding: utf-8
class SessionsController < ApplicationController

  def new
  end

  def create
    user = login(params[:username], params[:password], params[:remember_me])
    if user
      redirect_back_or_to dashboard_url, :notice => "Innlogget!"
    else
      flash.now.alert = "Feil brukernavn eller passord"
      render :new
    end
  end

  def destroy
    logout
    redirect_to login_url, :notice => "Avlogget å!"
  end

end