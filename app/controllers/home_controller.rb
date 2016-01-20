class HomeController < ApplicationController
  def index
    @action_name = user_signed_in? ? 'me' : 'index'
    render action: @action_name
  end
end
