Given /^I am an Admin$/ do
  #TODO 
  #Add Admin login stuff
end

Given /^There are users$/ do
  @carlo = User.create(first_name: "Carlo", last_name: "Cajucom", email: "carlo@herbalife.com")
  @fco = User.create(first_name: "Francisco", last_name: "Delgado", email: "francisco@herbalife.com")
end

Given /^I add SinatraAdmin as middleware$/ do
  Dummy.use SinatraAdmin
end

Given /^I register "(\w+)" resource$/ do |resource|
  SinatraAdmin.register 'User'
end
