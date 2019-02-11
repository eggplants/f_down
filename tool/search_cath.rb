def anlyse_index(board_id)
  require "open-uri"
  require "csv"
  puts "plz imput value of depth of searching (recommend: 100)"
  cc = gets.to_i#value of depth of searching
  cc = 100 if cc==0
  i = 0
  puts "now analysing #{cc.to_s} indexes..."
  data = CSV.read(File.join(__dir__, "../csv/category_#{board_id}.csv"))
  CSV.open(File.join(__dir__, "../csv/category_#{board_id}.csv"),'a') do |cath|
    for inc in (n = data[-1][0].to_i+1)..(n+cc)
      begin
        uri = "http://tsumanne.net/#{board_id}/cid.php?" + inc.to_s
        a = open(uri).read.scan(/<h2>(.*) .*<\/h2>/).flatten
        cath << [inc,a[0].gsub(/"/,"")] if a.size != 0
      rescue OpenURI::HTTPError => ex
        puts "Handle missing video here"
      rescue Interrupt
        puts "\nthis prog was interrupted! (in:#{inc})"
      end
      i += 1 if a.size != 0
      print a.size != 0 ? "#{inc} #{a[0]}\r"
       : "#{inc} nope\r"
    end
    puts "\nsearch finished!\nplz check csv file(category_#{board_id}.csv) out!"
    puts "new added index(es): #{i}"
  end
end
