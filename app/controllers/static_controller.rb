class StaticController < ApplicationController
  def home
  end

  def users
  	@users = User.all 
  end
end
