def show_thread(urls,indexes)
  a = "=====search result of #{indexes.join("&")}====="
  puts a
  puts "#{urls.size} thread(s) found!"
  urls.each do |url|
    source = open("https://tsumanne.net/#{url}").read
    titlen = source.scan(/e>(.* )-/).flatten
    titlen = titlen[0].encode("UTF-8", "Shift_JIS") if titlen != []
    puts("#{urls.index(url)+1}:#{titlen}","url==(#{url})")
  end
  puts "a"*a.size
end