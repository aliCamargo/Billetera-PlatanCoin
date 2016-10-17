class Transaction < ApplicationRecord
  belongs_to :account
  enum instruction: {deposito: 0, retiro: 1}

  after_create :set_account_balance

  validates :amount, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :amount, less_than_balance: true, if: Proc.new { |t| t.retiro? }

  private
  def set_account_balance
    balance =
      if self.deposito?
        self.account.balance + self.amount
      else
        self.account.balance - self.amount
      end

    self.account.update_attribute( :balance, balance )
  end
end
