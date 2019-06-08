class UsersController < ApplicationController
    # Not used here because this project was created with --api flag
    # skip_before_action :verify_authenticity_token

    def index
        render json: User.all
    end
    def show 
        render json: User.find(params["id"])
    end
    def create
        render json: User.create(params["user"])
    end
    def delete
        render json: User.delete(params["id"])
    end
    def update
        render json: User.update(params["id"], params["user"])
    end
    def countries
        render json: User.countries(params["id"])
    end
end