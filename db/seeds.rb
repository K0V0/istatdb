
# create root user
User.create(:email => 'admin@admin.hsdb', :password => '1234567890', :password_confirmation => '1234567890', is_admin: true)
