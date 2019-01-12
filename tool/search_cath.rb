def anlyse_index(board_id)
  require "open-uri"
  require "csv"
  cc = 1000
  puts "now analysing #{cc.to_s} indexes..."
  data = CSV.read("../csv/category_#{board_id}.csv")
  CSV.open("../csv/category_#{board_id}.csv",'a') do |cath|
    for inc in (n = data[-1][0].to_i+1)..(n+cc)
      begin
        uri = "http://tsumanne.net/#{board_id}/cid.php?" + inc.to_s
        a = open(uri).read.scan(/<h2>(.*) .*<\/h2>/)
        cath << [inc,a[0].gsub(/(\[|\]|")/,"").] if a.size != 0
      rescue OpenURI::HTTPError => ex
        puts "Handle missing video here"
      rescue Interrupt
        puts "\nthis prog was interrupted! (in:#{inc})"
        exit
      end
      puts a.size != 0 ? "#{inc} #{a[0]}\r" : "#{inc} nope\r"
      printf "\e[1A"
    end
    puts "search finished!\nplz check csv file(category_#{board_id}.csv) out!"
  end
end
