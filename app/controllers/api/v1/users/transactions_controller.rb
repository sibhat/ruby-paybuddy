module Api
    module V1
        module Users
            class TransactionsController < ApplicationController
                def index 
                    @transactions = Transaction.all
                    render json: @transactions
                end

                private

                def authorize_user!
                    return forbidden unless current_user.id == params[:user_id].to_i
                end
            end
        end
    end
end
