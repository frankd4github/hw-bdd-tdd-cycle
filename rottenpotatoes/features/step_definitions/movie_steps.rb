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

And /I am on the home page/ do
  visit movies_path
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  #page.body.should =~ /#{e1}.*#{e2}/m
  #expect(page.body).to match(/#{e1}.*#{e2}/m)
  td_elements = page.all("tbody td")
  i1 = td_elements.find_index {|td| td.text == e1}
  i2 = td_elements.find_index {|td| td.text == e2}
  expect(i1).to be <= i2
  #fail "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(/,\s*/).each do |rating|
    case uncheck
    when ''
      # check "ratings[#{rating[1..-2]}]"
      step %Q{I check "ratings[#{rating[1..-2]}]"}
    when 'un'
      # uncheck "ratings[#{rating[1..-2]}]"
      step %Q{I uncheck "ratings[#{rating[1..-2]}]"}
    end
  end
  #fail "Unimplemented"
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  expect(page.all('tbody tr').length).to be(Movie.all.length)
  #fail "Unimplemented"
end