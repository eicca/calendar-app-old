module ApplicationHelper
  def current_balance
    balance = current_user.balance
    return "#{balance} #{balance.currency}"
  end
end
