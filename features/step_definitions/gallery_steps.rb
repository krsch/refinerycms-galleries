Given /^I have no galleries$/ do
  Gallery.delete_all
end

Given /^I (only )?have galleries titled "?([^\"]*)"?$/ do |only, titles|
  Gallery.delete_all if only
  titles.split(', ').each do |title|
    Gallery.create(:title => title)
  end
end

Then /^I should have ([0-9]+) galler[y|ies]+?$/ do |count|
  Gallery.count.should == count.to_i
end
