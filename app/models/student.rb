class Student < ActiveRecord::Base
  has_many :lessons
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  monetize :balance_cents

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  validate :name, presence: true

  def purchase(amount, credentials)
    #credit_card = ActiveMerchant::Billing::CreditCard.new(credentials)
    #if credit_card.valid?
      #response = GATEWAY.purchase(amount, credit_card)
      #if response.success?
        self.balance += Money.new(amount, 'USD')
        # FIXME looks like Spanish ruby
        return !self.save!
      #else
        #return response.message
      #end
    #else
      #return 'invalid credit card'
    #end
  end

end
