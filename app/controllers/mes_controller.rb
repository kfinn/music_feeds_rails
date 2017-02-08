class MesController < ApplicationController
  before_action :authenticate_user!
  def show
    @me = current_user
  end
end
