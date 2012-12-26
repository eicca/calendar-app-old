class AddMoney < ActiveRecord::Migration
  def change
    add_money :students, :balance

    add_money :teachers, :balance
    add_money :teachers, :price
  end
end
