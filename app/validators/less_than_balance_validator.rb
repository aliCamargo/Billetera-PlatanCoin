class LessThanBalanceValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    if record.account.balance < value
      record.errors[attribute] << ( options[:message] || 'saldo insuficiente' )
    end
  end
end