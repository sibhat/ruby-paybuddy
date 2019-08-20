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

                sender_new_balance = @sender.balance - transfer_params[:balance];
                withdrawal = Transaction.create(
                    user_id: @sender.id,
                    transfer_uid: transfer_uid,
                    amount: transfer_params[:amount],
                    category: "withdrawal",
                    status: "pending",
                )
                receiver_new_balance = @receiver.balance + transfer_params[:amount]
                deposit = Transaction.create(
                    user_id: @receiver.id,
                    transfer_uid: transfer_uid,
                    amount: transfer_params[:amount],
                    category: "deposit",
                    status: "pending",
                )
                @receiver.update(balance: receiver_new_balance)
                deposit.update(status: "processed")
                @sender.update(balance: sender_new_balance);
                withdrawal.update(status: "processed")
                


                render json:{
                    message: "Transfer requested",
                    amount: transfer_params[:amount],
                    email: transfer_params[:email]
                }
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
