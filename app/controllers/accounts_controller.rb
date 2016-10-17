class AccountsController < ApplicationController

  before_action :verify_header, only: [:add_transaction]
  before_action :set_account, only: [:show, :add_transaction]

  def index
    @accounts = Account.all
  end

  def show
    @transaction = @account.transactions.new
  end

  def add_transaction
    @transaction = @account.transactions.new( transaction_params )
    @transaction.save

    if request.headers['X-Secret'] == 'verysecure'
      if @transaction.errors.any?
        render json: @transaction.errors
      else
        render json: @transaction
      end

    else
      render 'show'
    end
  end

  private
  def set_account
    @account ||= Account.find_or_create_by!( address: params[:address] )
  end

  def transaction_params
    params.require(:transaction).permit(:description, :amount, :instruction )
  end

  def verify_header
    if request.headers['X-Secret'].present?
      render json: { errors: { message: 'unauthorized' } },
             status: :unauthorized unless request.headers['X-Secret'] == 'verysecure'
    end
  end
end
