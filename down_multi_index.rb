#retrieve thread url by index
require 'open-uri'
require 'fileutils'
require 'csv'
def index_htms(board,index)
  thread_url = []
  for j in 0..300
    source = OpenURI
    .open_uri(URI.encode("https://tsumanne.net/#{board}/#{index}/#{j.to_s}")).read
    puts("Now analysing:#{j+1} page...")
    an = source
    .scan(/[a-z]{2}.{1}[a-z]{4}.{1}[0-9]{4}.{1}[0-9]{2}.{1}[0-9]{2}.{1}[0-9]{7}/)
    .uniq.flatten
    thread_url.push(an) if an.size != 0
    break if an.size == 0
  end
  puts "#{thread_url.size} thread(s) found!"
  return thread_url
end

def down_thread(board,index,thread_url)
  begin#ctrl+C
    thread_url.each do |koshiro|
      source = OpenURI.open_uri("https://tsumanne.net/#{koshiro}").read
      (htmName = source.scan(/[0-9]{9}.htm/)).each do |htm|
        print('Now analysing:',htm, " page...\n")
        dirName = ""
        File.open('save_dir.txt') do |file|
          dirName = "#{file.read}#{board}/#{index.join("/")}/"
        end
        fileDir = "#{dirName}#{htm};#{index.join("_")}"
        unless FileTest.exist?(fileDir)
          FileUtils.mkdir_p(fileDir)
        else
          puts "exist!"
        end
        htmPath = fileDir + "/" + htm
        htm_src = 'https://tsumanne.net/' + koshiro + "/" + htm
        print("Now saving:", htm, "...")
        # write htm data
        open(htmPath, 'wb') do |output|
          begin
            output.write(source.gsub(/shift-JIS/, "UTF-8"))
            puts("successful!\n")
          rescue => er
            puts $!
          end
        end
        thread_data_0 = source.scan(/[0-9]{10,}\.[a-z]{3,4}/)
        thread_data_1 = source.scan(/[a-z]{2}[0-9]+\.[a-z]{3,4}/).push(thread_data_0).flatten
        thread_data_2 = source.scan(/[0-9]+s\.\w{3,4}/).push(thread_data_1).flatten.uniq
        thread_data_2.each do |odaie|
          img_src = "https://tsumanne.net/#{koshiro}/#{odaie}"
          print('Now saving:', odaie, '...')
          fileName = File.basename(img_src)
          filePath = "#{fileDir}/#{fileName}"
          unless FileTest.exist?(filePath)
            # write image adata
            open(filePath, 'wb') do |output|
              begin
                open(img_src) {|data|
                  output.write(data.read)
                  puts "successful!\n"
                }
              rescue => er
                puts $!
                CSV.open("/home/eggplant/Downloads/futaba_log/not_found.csv",'a') do |log|
                  log << [htm,odaie,index]
                end
              end
            end
          else
            puts "exist!"#already retrieved for past more than one time
          end
        end
      end
    end
  rescue Interrupt
      puts "\nthis prog was interrupted!"
  end
end
