# Taken from the cucumber-rails project.

module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home page/
      '/admin'
    when /the login page/
      '/admin/login'
    when /my custom page/
      '/admin/customs'
    when /users listing/
      '/admin/users'
    when /users custom page/
      '/admin/users/custom'
    when /user create new/
      '/admin/users/new'
    when /user Carlo edit/
      "/admin/users/#{@carlo.id}/edit"
    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
