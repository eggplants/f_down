#Todo : １０こひょうじしたら残り数とy or nをせんたく
require_relative "./down_single_index"
require_relative "./down_multi_index"
require_relative "./search_cath"
require_relative "./exist_index"
require_relative "./search_thread_by_index"
require "open-uri"
################################################################################
loop do
  begin
  puts <<-EOS
*plz select num*
(if wanna exit, enter "exit")
===menu===
1, download by single-index
2, download by multi-index
3, analyse existing index(plz do this on a legular basis)
4, look up existense of index
5, search threads by index(es)
6, confirm save path (save_dir.txt)
  EOS
  app = gets.chomp.to_s
################################################################################
  boards = {:img=>"si",:may=>"my",:test_jun=>"tj",:dat=>"sa",:special=>"sp"}
################################################################################
  if app == "1"
    puts "*plz select board*\n(Now u can choose: img, may, test_jun, dat)"
    board_id = gets.chomp.to_s
################################################################################
    if boards.has_key?(board_id.to_sym)
      puts '*plz input index you wanna download*'
      index = gets.chomp.to_s
      retrieve_url(boards[board_id.to_sym],index)
    else
      puts "plz input board name!!!"
    end
################################################################################
  elsif app == "2"
    puts "*plz select board*","(Now u can choose: img, may, test_jun, dat)"
    board_id = gets.chomp.to_s
    unless boards.has_key?(board_id.to_sym)
      puts "plz board name!!!"
    else
      urls,indexes,thread_url,f = [],[],[],0
      File.open(File.join(__dir__, "save_dir.txt")) do |file|
        puts '*plz input indexs you wanna download(To exit, type ".")*'
        while (index = gets.chomp.to_s) != "."
          indexes.push(index)
          puts "now, path downloaded threads are saved is:
          #{file.read}#{boards[board_id.to_sym]}/#{indexes.join("/")}/"
################################################################################
          case f
          when 0
            urls
            .push(index_htms(boards[board_id.to_sym],index,thread_url).flatten)
            .flatten!;f+=1
          else
            urls = urls & index_htms(boards[board_id.to_sym],index,thread_url)
            .flatten
          end
################################################################################
          puts "duplicate thread(s): #{urls.size}"
          sleep(1)
          puts "show lists?(y/n)"
################################################################################
          if gets.chomp.to_s=="y"
            urls.each do |url|
              source = open("https://tsumanne.net/#{url}").read
              if (titlen = source.scan(/e>(.* )-/).flatten)!=nil
                titlen = titlen[0].encode("UTF-8", "Shift_JIS") if titlen != []
                titlen = "ｷﾀ━━━━━━(ﾟ∀ﾟ)━━━━━━ !!!!!" if titlen == []
                puts "#{urls.index(url)+1}:#{titlen}","url==(https://tsumanne.net/#{url})"
              end
            end
          end#listshow-yn-end
################################################################################
          puts '*plz input indexs you wanna download(To exit, type ".")*'
        end#while-end
      end#file.open-end
      down_thread(boards[board_id.to_sym],indexes,urls)
    end#else-end
################################################################################
  elsif app == "3"
    puts "*plz select board*","(Now u can choose: img, may, test_jun, dat)"
    board_id = gets.chomp.to_s
    anlyse_index(boards[board_id.to_sym]) if boards.has_key?(board_id.to_sym)
################################################################################
  elsif app == "4"
    puts "*plz input index you wanna view*"
    index = gets.chomp.to_s
    retrieve_htm_n(index)
################################################################################
  elsif app == "5"
    puts "*plz select board*","(Now u can choose: img, may, test_jun, dat)"
    board_id = gets.chomp.to_s
    unless boards.has_key?(board_id.to_sym)
      puts "plz board name!!!"
    else
      urls,indexes,thread_url,f = [],[],[],0
      File.open(File.join(__dir__, "save_dir.txt")) do |file|
        puts '*plz input indexs you wanna search(To exit, type ".")*'
        while (index = gets.chomp.to_s) != "."
          indexes.push(index)
          puts "now, your selected index(es) are: /#{indexes.join("/")}/"
################################################################################
          case f
          when 0
            urls
            .push(index_htms(boards[board_id.to_sym],index,thread_url)
            .flatten).flatten!;f+=1
          else
            urls = urls & index_htms(boards[board_id.to_sym],index,thread_url)
            .flatten
          end
################################################################################
          puts "duplicate thread(s): #{urls.size}"
          sleep(1)
          puts "show lists?(y/n)"
################################################################################
          if gets.chomp.to_s=="y"
          urls.each{|u|
            source = open("https://tsumanne.net/#{u}").read
            if (titlen = source.scan(/e>(.* )-/).flatten)!=nil
              titlen = titlen[0].encode("UTF-8", "Shift_JIS") if titlen != []
              titlen = "ｷﾀ━━━━━━(ﾟ∀ﾟ)━━━━━━ !!!!!" if titlen == []
              puts "#{urls.index(u)+1}:#{titlen}",
              "url==(https://tsumanne.net/#{u})"
            end
          }
          end
################################################################################
          puts '*plz input indexs you wanna search(To exit, type ".")*'
        end
      end
    end
################################################################################
  elsif app == "6"
    puts %(path:#{File.open(File.join(__dir__, "save_dir.txt")).read})
################################################################################
  elsif app == "exit"
    break
  end
################################################################################
rescue Interrupt
  puts "\nexit?(y/n)"
  exit! if /y/ =~ gets.to_s
end
################################################################################
end#loop-end
puts "E&E!!"
