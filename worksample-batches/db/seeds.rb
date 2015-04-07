# create a demo user
user = User.find_or_create_by_email!('demo@easypost.com') do |u|
  u.assign_attributes(
    name: 'Demo User',
    password: 'password',
    password_confirmation: 'password',
  )
end
user.api_keys.where(mode: EasyPost::ApiMode::TEST).first.update_attributes({key: "123456789"})

