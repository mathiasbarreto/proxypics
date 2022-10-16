FactoryBot.define do
  factory :requester do
    sequence(:email) { |n| "test-#{n.to_s.rjust(3, '0')}@example.com" }
    password { 'password' }
  end
end