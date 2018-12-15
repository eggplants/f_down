while (app = gets.chomp.to_i) !~ /\d{1}/
  puts "*plz select num*"
  puts "(if wanna exit, enter without number)"
  puts "===menu==="
  puts "1, download by single-index"
  if app == 1
    require_relative "down_single_index"
    retrieve_url
  end
end
