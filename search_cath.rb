def anlyse_index(board_id)
  require "open-uri"
  require "csv"
  puts "now analysing 100 indexes..."
  data = CSV.read("category_#{board_id}.csv")
  CSV.open("category_#{board_id}.csv",'a') do |cath|
    for inc in (n = data[-1][0].to_i+1)..(n+100)
      begin
        uri = 'http://tsumanne.net/tj/cid.php?' + inc.to_s
        a = open(uri).read.scan(/<h2>(.*) .*<\/h2>/)
        cath << [inc,a[0]] if a.size != 0
      rescue OpenURI::HTTPError => ex
        puts "Handle missing video here"
      rescue Interrupt
        puts "\nthis prog was interrupted! (in:#{inc})"
        exit
      end
      print "#{inc}\r" if a.size != 0
      print "nope'D.\r" if a.size == 0
      STDOUT.flush
    end
    puts "search finished!\nplz check csv file(category_#{board_id}.csv) out!"
  end
end
