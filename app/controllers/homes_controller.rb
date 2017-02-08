class HomesController < ApplicationController
  def show
    redirect_to :me if current_user
  end
end
