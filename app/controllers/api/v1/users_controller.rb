module Api
    module V1
        class UsersController < ApplicationController
            before_action :authenticate_user!, except: [:create]
            before_action :authorize_user!, only: [:update, :transfer]

            def index
                @users = User.all
                render json: @users
            end
            def show
                @user = User.find(params [:id])

                render json: @user

            end
            def create
                @user = User.new(user_params)
                @user.save!

                render json: @user
            end
            def update
                @user = User.find(params [:id])
                @user.update!(user_params)
                render json: @user
            end

            def transfer
                @sender = User.find(params[:id])
                @receiver = User.find_by(emai: transfer_params[:email])
                transfer_uid = SecureRandom.uuid

                @receiver.deposit(transfer_params[:amoiunt], transfer_uid);
                @sender.withdrawal(transfer_params[:amoiunt], transfer_uid)
               
                render json: @sender
            end

            private

            def user_params
                params.permit(:name, :email, :balance)
            end
            def transfer_params
                params.permit(:amount, :email)
            end
            
            def authorize_user!
                return forbidden unless current_user.id == params[:id].to_i
            end
        end
    end
end
