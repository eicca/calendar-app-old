ActiveMerchant::Billing::Base.mode = :test

GATEWAY = ActiveMerchant::Billing::TrustCommerceGateway.new(
  :login => 'TestMerchant',
  :password => 'password')
