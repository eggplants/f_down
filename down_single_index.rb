begin
require 'open-uri'
require 'fileutils'
require 'csv'
def retrieve_url(index)
  puts '*plz input index you wanna download*'
  index = gets.chomp.to_s
  for j in 0..300
    aaa = "https://tsumanne.net/si/" + index + "/" + j.to_s
    aaan = URI.encode(aaa)
    io_1 = OpenURI.open_uri(aaan)
    print('Now analysing:', j+1, " page...")
    io_1source = io_1.read
    thread_url = io_1source
    .scan(/[a-z]{2}.{1}[a-z]{4}.{1}[0-9]{4}.{1}[0-9]{2}.{1}[0-9]{2}.{1}[0-9]{7}/).uniq
    aaannn = thread_url.size
    if aaannn == 0
      puts 'download finished!', 'E&E!'
      exit!
    end
    thread_url.each {|koshiro|
      print("Now analysing:", j + 1, " page...\n")
      anan = "https://tsumanne.net/" + koshiro
      begin
        io_2 = OpenURI.open_uri(anan)
      rescue => e
        puts $!
        break
      end
      io_2source = io_2.read
      htmName = io_2source.scan(/[0-9]{9}.htm/)
      htmName.each {|htm|
        print('Now analysing:',htm, " page...\n")
        dirName = "/home/eggplant/Downloads/futaba_log/" + index + "/"
        fileDir = dirName + htm + ';' + index
        unless FileTest.exist?(fileDir)
            FileUtils.mkdir_p(fileDir)
        end
        htmPath = fileDir + "/" + htm
        htm_src = 'https://tsumanne.net/' + koshiro + "/" + htm
        print("Now saving:", htm, "...")
        # write htm data
        open(htmPath, 'wb') {|output|
        begin
          output.write(io_2source.gsub(/shift-JIS/, "UTF-8"))
          puts "successful!\n"
         rescue => er
          puts $!
        end
        }
        thread_data_0 = io_2source.scan(/[0-9]{10,}\.[a-z]{3,4}/)
        thread_data_1 = io_2source.scan(/[a-z]{2}[0-9]+\.[a-z]{3,4}/).push(thread_data_0).flatten
        thread_data_2 = io_2source.scan(/[0-9]+s\.\w{3,4}/).push(thread_data_1).flatten.uniq
        thread_data_2.each {|odaie|
          img_src = 'https://tsumanne.net/' + koshiro + "/" + odaie
          print('Now saving:', odaie, '...')
          fileName = File.basename(img_src)
          filePath = fileDir + "/" + fileName
          unless FileTest.exist?(filePath)
          # write image adata
          open(filePath, 'wb') {|output|
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
          }
        else
          puts "exist!"
        end
        }
      }
    }
  end
end
