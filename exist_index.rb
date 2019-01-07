def retrieve_htm_n(index)
  require "csv"
  for id in ["si","my","tj"]
    data = Hash.new{|h,k| h[k]=[]}
    CSV.foreach("category_#{id}.csv", headers: true) do |row|
      data[row["index"]] << row
    end
    ind_id = data[index].to_s.scan(/\d+/)
    print("this index page is http://tsumanne.net/",
      id,"/cid.php?",ind_id[0],"\n") unless data[index].size == 0
    puts "this index does not exist in category_#{id}.csv!" if data[index].size == 0
  end
end
