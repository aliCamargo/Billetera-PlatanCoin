class AccountsController < ApplicationController

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
    render 'show'
  end

  private
  def set_account
    @account ||= Account.find_or_create_by!( address: params[:address] )
  end

  def transaction_params
    params.require(:transaction).permit(:description, :amount, :instruction )
  end
end
