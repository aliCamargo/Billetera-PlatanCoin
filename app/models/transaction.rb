class Transaction < ApplicationRecord
  belongs_to :account
  enum instruction: {deposito: 0, retiro: 1}

  after_create :set_account_balance

  validates :amount, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, less_than_balance: true

  private
  def set_account_balance
    self.account.update_attribute( :balance, self.account.balance - self.amount )
  end
end
