def check_reg_mark_format
  # Checks letters are upper case and valid Alpha numeric format
  expect(@reg_mark).to match(/[A-Z]{2}[0-9]{2}[A-Z]{3}/)
end

def check_region
  reg_mark_region_id = @reg_mark[0]
  # Check the first character is a valid region A,B,C,D,E,F,G,H,K,L,M,N,O,P,R,S,V,W,X,Y
  expect(reg_mark_region_id).to match(/[A-HK-PRSVWXY]/)
end

def check_area_code
  reg_mark_area_code = @reg_mark[1]
  # Check the second character is not I or Q
  expect(reg_mark_area_code).to match(/[^IQiq]/)
end

def check_age_identifier
  age_identifier = @reg_mark[2, 2].to_i
  current_year = Date.today.strftime('%y').to_i
  current_month = Date.today.strftime('%m').to_i

  # Determines the valid age identifiers for each month
  if [1, 2].include?(current_month)
    valid_mar_aug_age_id = current_year - 1
    valid_sep_feb_age_id = current_year + 49
  elsif [3, 4, 5, 6, 7, 8].include?(current_month)
    valid_mar_aug_age_id = current_year
    valid_sep_feb_age_id = current_year + 49
  else
    valid_mar_aug_age_id = current_year
    valid_sep_feb_age_id = current_year + 50
  end

  # Returns a message when the reg mark has a valid age identifier or
  # a error message when it has not be issued yet or is invalid
  case age_identifier

  when 0
    raise StandardError, "Invalid age identifier 00 for #{@reg_mark}"
  when 1..valid_mar_aug_age_id
    p "#{@reg_mark} registered between March 20#{format_year(age_identifier)} and August 20#{format_year(age_identifier)}"
  when 51..valid_sep_feb_age_id
    p "#{@reg_mark} registered between September 20#{format_year(age_identifier - 50)} and February 20#{format_year(age_identifier - 49)}"
  else
    raise StandardError, "Invalid age identifier #{age_identifier} not yet issued for #{@reg_mark}"
  end
end

def format_year(year)
  format('%02d', year)
end
