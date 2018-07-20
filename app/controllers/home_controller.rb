class HomeController < ApplicationController
  def index
    @teams = Team.all
  end

  def random
  end
end
