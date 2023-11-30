class HomeController < ApplicationController
    skip_before_action :authenticate_user!, only: :auto_login

    def index
        render
    end

    def auto_login
        render
    end
end
