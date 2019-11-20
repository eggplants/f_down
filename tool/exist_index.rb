def retrieve_htm_n(index)
  require 'csv'

  for id in ["si","my","tj","sa","sp"]
    data = Hash.new{|h,k| h[k]=[]}
    csvpath=File.join(__dir__, "../csv/category_#{id}.csv")
    CSV.foreach(csvpath, headers: true) do |row|
      data[row["index"]] << row
    end
    ind_id = data[index].to_s.scan(/\d+/)
    if data[index].size != 0
      puts "this index page is http://tsumanne.net/#{id}/cid.php?#{ind_id[0]}"
      puts "this index does not exist in category_#{id}.csv!"
    end
  end
end
