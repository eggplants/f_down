def retrieve_url(board,index)
  require 'open-uri'
  require 'fileutils'
  require 'csv'
  for j in 0..300
    aaa = "https://tsumanne.net/#{board}/" + index + "/" + j.to_s
    aaan = URI.encode(aaa)
    io_1 = OpenURI.open_uri(aaan)
    puts("Now analysing:#{j+1} page...")
    io_1source = io_1.read
    thread_url = io_1source
    .scan(/[a-z]{2}.{1}[a-z]{4}.{1}[0-9]{4}.{1}[0-9]{2}.{1}[0-9]{2}.{1}[0-9]{1,7}/).uniq
    aaannn = thread_url.size
    if aaannn == 0
      puts %q(download finished! E&E!)
      break
    end
    thread_url.each {|koshiro|
      anan = "https://tsumanne.net/#{koshiro}"
      io_2 = OpenURI.open_uri(anan)
      io_2source = io_2.read
      titlen = io_2source.scan(/e>(.* )-/).flatten
      titlen = titlen == [] ? "ｷﾀ━━━━━━(ﾟ∀ﾟ)━━━━━━ !!!!!"
       : titlen[0].encode("UTF-8", "Shift_JIS")
      htmName = io_2source.scan(/[0-9]{9}.htm/)
      htmName.each {|htm|
        print('Now analysing:',htm, " page...\n")
        dirName = ""
        File.open(File.join(__dir__, "save_dir.txt")) do |file|
          dirName = "#{file.read.chomp}#{board}/#{index}/"
        end
        fileDir = titlen != [] ? "#{dirName}#{htm};#{index};#{titlen}"
         : "#{dirName}#{htm};#{index}"
        begin
        unless FileTest.exist?(fileDir)
            FileUtils.mkdir_p(fileDir)
            FileUtils.cp([File.join(__dir__, "../style/th.css"), File
            .join(__dir__, "../style/th.js")], fileDir)
        end
        rescue Errno::EACCES
          puts 'please check setting "save_dir.txt"!'
          exit
        end
        htmPath = "#{fileDir}/#{htm}"
        print !titlen.empty? ? "Now saving:#{htm}-[#{titlen}]..."
         : "Now saving:#{htm}-[ｷﾀ━━━━━━(ﾟ∀ﾟ)━━━━━━ !!!!!]..."
        # write htm data
        open(htmPath, 'wb') {|output|
        begin
          output.write(io_2source.sub(/src.*js"/, 'src="./th.js"'))
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
          img_src = "https://tsumanne.net/#{koshiro}/#{odaie}"
          print('Now saving:', odaie, '...')
          fileName = File.basename(img_src)
          filePath = "#{fileDir}/#{fileName}"
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
            CSV.open(File.join(__dir__, "../csv/not_found.csv",'a')) do |log|
              log << [htm,odaie,index]
          end;end
          }
        else
          puts "exist!"
        end
      }}}
end;end
