FactoryBot.define do
  factory :user do
    full_name {"Test User"}
    email {"test@email.com"}
    password {"password"}
    role {1}
  end
end