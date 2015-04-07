Given /^I am an Admin$/ do
  @admin = SinatraAdmin.config.admin_model.create(email: "admin@mail.com", password: "admin") 
end

Given /^I am logged in as admin$/ do
  login_as @admin, scope: :sinatra_admin
end

Given /^I got role "(.*?)"$/ do |role|
  @admin.update_attribute(:roles, role.split(', '))
end

Given /^There are users$/ do
  @carlo = User.create(first_name: "Carlo", last_name: "Cajucom", email: "carlo@herbalife.com", password_hash: "cpass", created_at: 2.day.ago.utc)
  @fco = User.create(first_name: "Francisco", last_name: "Delgado", email: "francisco@herbalife.com", password_hash: "fpass", created_at: 1.day.ago.utc)
  @vahak = User.create(first_name: "Vahak", last_name: "Matavosian", email: "vahak@herbalife.com", password_hash: "vpass", created_at: Time.now.utc)
end

Given /^There are not users$/ do
  User.destroy_all
end

Given /^I add SinatraAdmin as middleware$/ do
  Dummy::Admin.use SinatraAdmin::App
end

Given /^I register "(\w+)" resource$/ do |resource|
  SinatraAdmin.register resource
end

Given /^I set (\d+) items per page$/ do |per_page|
  WillPaginate.per_page = per_page.to_i
end

Given /^I register "(\w+)" resource with custom route$/ do |resource|
  SinatraAdmin.register resource do
    get '/custom/?' do
      @message = "Welcome to Resource model custom page"
      haml "users/custom".to_sym
    end
  end
end

Given /^I register my custom page$/ do
  SinatraAdmin.register 'Custom' do
    get '/?' do
      @welcome_msg = 'Welcome to SinatraAdmin custom pages!'
      @admin_count = SinatraAdmin::Admin.count
      haml 'customs/index'.to_sym
    end
  end
end

Given /^I add main app views to SinatraAdmin views$/ do
  SinatraAdmin.extend_views_from(Dummy::API)
end

Given /^I define "(\w+)" as root resource$/ do |resource|
  SinatraAdmin.root resource
end

When /^I click on Carlo id$/ do
  click_link(@carlo.id.to_s)
end

When /^I click on Carlo remove button$/ do
  click_button("delete_#{@carlo.id.to_s}")
end

When(/^I click on Export "(.*?)"$/) do |export_by|
  click_link("Export #{export_by}")
end
