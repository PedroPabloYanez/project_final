class HomeController < ApplicationController
    def index
        if user_signed_in?
            @projects = Project.all
            @teams = Team.all
        end    
    end
  end