class AuthController < ApplicationController
    before_action :authorize_user!, only: [:show]

    def show
        render json: {
          user_id: find_current_user["user_id"],
          username: find_current_user["username"]
        }
    end

    def create
        user = User.find_by_username(params["auth"]["username"])
        passMatch = test_password(params["auth"]["password"], user["password"])
        
        if user && passMatch
            p 'match password!'
            created_jwt = issue_token({id: user["user_id"]})
            p created_jwt
            cookies.signed[:jwt] = {
                value: created_jwt,
                httponly: true
            }
            render json: {username: user["username"], user_id: user["user_id"], jwt: created_jwt}
        else
            p "failed password match"
            render json: {
                error: 'Username or password incorrect'
            }, status: 404
        end
        
            # 'username' => params["auth"]["username"],
            # 'password' => params["auth"]["password"]
    end

    

end