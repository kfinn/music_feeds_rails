# frozen_string_literal: true

class HomesController < UnauthenticatedController
  def show
    redirect_to :me if current_user
  end
end
