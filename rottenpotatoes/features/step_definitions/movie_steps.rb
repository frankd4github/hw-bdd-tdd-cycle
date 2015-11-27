Given /^the following movies exist:$/ do |table|
  # table is a Cucumber::Ast::Table
  # pending # express the regexp above with the code you wish you had
  table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create(movie)
  end
end

Then /^the director of "(.*?)" should be "(.*?)"$/ do |arg1, arg2|
  #pending # express the regexp above with the code you wish you had
  expect(Movie.find_by_title(arg1).director).to be == arg2
end

Given /^I am on the details page for "(.*?)"$/ do |title|
  #pending # express the regexp above with the code you wish you had
  visit movie_path(Movie.find_by_title title)
end