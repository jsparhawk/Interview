Given(/^I have a (.*)$/) do |registration_mark|
  @reg_mark = registration_mark
end

When(/^the format is valid$/) do
  check_reg_mark_format
  check_region
  check_area_code
end

Then(/^I can register a vehicle$/) do
  p "Valid registration mark #{@reg_mark} registered"
end

When(/^the year of registration is valid$/) do
  check_age_identifier
end
