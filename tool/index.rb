require_relative "./down_single_index"
require_relative "./down_multi_index"
require_relative "./search_cath"
require_relative "./exist_index"
begin
loop do
  puts "*plz select num*"
  puts '(if wanna exit, enter "exit")'

  puts "===menu==="
  puts "1, download by single-index"
  puts "2, download by multi-index"
  puts "3, anlyse existing index(plz do this on a legular basis)"
  puts "4, look up existense of index"
  app = gets.chomp.to_s
  if app == "1"
    boards = {:img => "si", :may => "my", :test_jun => "tj", :dat => "sa"}
    puts "*plz select board*"
    puts '(Now u can choose: img, may, test-jun, dat)'
    board_id = gets.chomp.to_s
    if boards.has_key?(board_id.to_sym)
      puts '*plz input index you wanna download*'
      index = gets.chomp.to_s
      retrieve_url(boards[board_id.to_sym],index)
    else
      puts "plz input board name!!!"
    end


  elsif app == "2"
    boards = {:img => "si", :may => "my", :test_jun => "tj", :dat => "sa"}
    puts "*plz select board*"
    puts '(Now u can choose: img, may, test_jun, dat)'
    board_id = gets.chomp.to_s
    if boards.has_key?(board_id.to_sym)
      urls,indexes = [],[]
      File.open('save_dir.txt') do |file|
        puts '*plz input indexs you wanna download(To exit, type ".")*'
        while (index = gets.chomp.to_s) != "."
          indexes.push(index)
          puts "now, path downloaded threads are saved is: #{file.read}#{boards[board_id.to_sym]}/#{indexes.join("/")}/"
          urls.push(index_htms(boards[board_id.to_sym],index))
          puts '*plz input indexs you wanna download(To exit, type ".")*'
        end
      end
      down_thread(boards[board_id.to_sym],indexes,urls.flatten!.uniq!)
    else
      puts "plz board name!!!"
    end


  elsif app == "3"
    boards = {:img => "si", :may => "my", :test_jun => "tj", :dat => "sa"}
    puts "*plz select board*"
    puts '(Now u can choose: img, may, test_jun, dat)'
    board_id = gets.chomp.to_s
    anlyse_index(boards[board_id.to_sym]) if boards.has_key?(board_id.to_sym)


  elsif app == "4"
    puts '*plz input index you wanna view*'
    index = gets.chomp.to_s
    retrieve_htm_n(index)
  elsif app == "exit"
    break
  end
end
puts "E&E!!"
3.times{print(".");sleep(1)}
puts
rescue Interrupt
  puts "\nthis prog was interrupted!"
end
