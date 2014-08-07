Given /^I am an Admin$/ do
  @admin = SinatraAdmin.config.admin_model.create(email: "admin@mail.com", password: "admin") 
end

Given /^I am logged in as admin$/ do
  login_as @admin, scope: :admin
end

Given /^There are users$/ do
  @carlo = User.create(first_name: "Carlo", last_name: "Cajucom", email: "carlo@herbalife.com")
  @fco = User.create(first_name: "Francisco", last_name: "Delgado", email: "francisco@herbalife.com")
end

Given /^There are not users$/ do
  User.destroy_all
end

Given /^I add SinatraAdmin as middleware$/ do
  Dummy.use SinatraAdmin::App
end

Given /^I register "(\w+)" resource$/ do |resource|
  SinatraAdmin.register resource
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
