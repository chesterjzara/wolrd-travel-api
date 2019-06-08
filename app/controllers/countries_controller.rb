class CountriesController < ApplicationController
    # Not used here because this project was created with --api flag
    # skip_before_action :verify_authenticity_token

    def index
        render json: Country.all
    end
    def show
        render json: Country.find(params["id"])
    end
    def showByUser 
        render json: Country.findByUser(params["userid"])
    end
    def create
        render json: Country.create(params["country"])
    end
    def delete
        render json: Country.delete(params["id"])
    end
    def update
        render json: Country.update(params["id"], params["country"])
    end
    def countries
        render json: Country.countries(params["id"])
    end
end