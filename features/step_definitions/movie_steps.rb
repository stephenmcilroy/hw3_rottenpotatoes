# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  @movie_count = 0
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
	@movie = Movie.create!(movie)
  @movie_count = @movie_count + 1
  end
  assert @movie_count
end

Then /I should see (all|none) of the movies/ do |view|
  rows = page.all('table#movies tbody tr').size
  if view == 'all'
    rows.should == @movie_count
  elsif view == 'none'
    rows.should == 0
  end
end

# Make sure that one string (regexp) occurs before or after another one
# on the same page
Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  #  page.body is the pages html body as one giant string.
 
  regex1 = Regexp.new(".*" + e1 + ".*")
  regex2 = Regexp.new(".*" + e2 + ".*")
  
  if (regex1 =~ page.body) < (regex2 =~ page.body)
    assert true
  else
    assert false
  end
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(/,\s*/).each do |r|
    if uncheck 
      step %Q{I uncheck "ratings_#{r}"}
    else
      step %Q{I check "ratings_#{r}"}
    end
  end	
end
