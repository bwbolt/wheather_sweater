FactoryBot.define do
  factory :user do
    email { 'MyString@gmail.com' }
    password { 'MyString' }
    password_confirmation { 'MyString' }
  end
end
