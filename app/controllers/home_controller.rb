class HomeController < ApplicationController
  def index
    @teams = Team.all
  end

  def random
    @teams = Team.random(15)
  end
end
