#retrieve thread url by index
require 'open-uri'
require 'fileutils'
require 'csv'
def index_htms(board,index,thread_url)
  thread_url=[]
  for j in 0..300
    source = OpenURI.open_uri(URI
      .encode("https://tsumanne.net/#{board}/#{index}/#{j.to_s}")).read
    puts("Now analysing:#{j+1} page...")
    an = source.scan(/[a-z]{2}.{1}[a-z]{4}.{1}[0-9]{4}.{1}[0-9]{2}.{1}[0-9]{2}.{1}[0-9]{1,7}/)
    .uniq.flatten
    an.size != 0 ? thread_url.push(an) : break
  end
  puts "#{thread_url.flatten.size} thread(s) found!"
  return thread_url
end

def down_thread(board,index,thread_url)
    thread_url.each do |koshiro|#thread urls
      source = OpenURI.open_uri("https://tsumanne.net/#{koshiro}").read
      titlen = source.scan(/e>(.* )-/).flatten
      titlen = titlen == [] ? "ｷﾀ━━━━━━(ﾟ∀ﾟ)━━━━━━" : titlen[0].encode("UTF-8", "Shift_JIS")
      (htmName = source.scan(/[0-9]{9}.htm/)).each do |htm|
        print('Now analysing:',htm, " page...\n")
        dirName = ""
        File.open(File.join(__dir__, "save_dir.txt")) do |file|#load directory where save files
          dirName = "#{file.read.chomp}#{board}/#{index.join("/")}/"
        end
        fileDir = titlen != [] ? "#{dirName}#{htm};#{index.join(",")};#{titlen}"
         : "#{dirName}#{htm};#{index}"
        begin
        unless FileTest.exist?(fileDir)
          FileUtils.mkdir_p(fileDir)
          FileUtils.cp([File.join(__dir__, "../style/th.css"),
          File.join(__dir__, "../style/th.js")], fileDir)
        else
          puts "exist!"
        end
        rescue Errno::EACCES
          puts 'please check setting "save_dir.txt"!'
          exit
        end
        htmPath = "#{fileDir}/#{htm}"
        print !titlen.empty? ? "Now saving:#{htm}-[#{titlen}]..."
         : "Now saving:#{htm}-[ｷﾀ━━━━━━(ﾟ∀ﾟ)━━━━━━ !!!!!]..."
        open(htmPath, 'wb') do |output|#save thread htm file
          begin
            output.write(source.sub(/src.*js"/, 'src="./th.js"').gsub(/shift-JIS/, "UTF-8"))
            puts "successful!\n"
          rescue => er
            puts $!
          end
        end
        thread_data_0 = source.scan(/[0-9]{10,}\.[a-z]{3,4}/)
        thread_data_1 = source.scan(/[a-z]{2}[0-9]+\.[a-z]{3,4}/).push(thread_data_0).flatten
        thread_data_2 = source.scan(/[0-9]+s\.\w{3,4}/).push(thread_data_1).flatten.uniq
        (source.scan(/[0-9]+s\.\w{3,4}/).push(thread_data_1).flatten.uniq).each do |odaie|
          img_src = "https://tsumanne.net/#{koshiro}/#{odaie}"
          print('Now saving:', odaie, '...')
          fileName = File.basename(img_src)
          filePath = "#{fileDir}/#{fileName}"
          unless FileTest.exist?(filePath)
            open(filePath, 'wb') do |output|#save thread pictures
              begin
                open(img_src) {|data|
                  output.write(data.read)
                  puts "successful!\n"
                }
              rescue => er
                puts $!
                CSV.open(File.join(__dir__, "../csv/not_found.csv"),'a') do |log|
                  log << [htm,odaie,index]
            end;end;end
          else
            puts "exist!"#already retrieved for past more than one time
    end;end;end;end
 end
