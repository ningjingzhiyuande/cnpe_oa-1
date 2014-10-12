#require 'spreadsheet'
namespace :user do
	
   desc 'import user' 
   task :import => :environment do 

    	puts  "导入用户的文件地址(绝对的地址)\n"
    	#file =  STDIN.gets.chomp
    	file = "/home/yang/Desktop/CGBPDetail.xls"
    	content = Roo::Spreadsheet.open(file)
    	#binding.pry
    	(2..481).to_a.each do |i|
           hash={}
          # ["A","B","C","H"].each do |col|
              hash["name"]=content.cell("A",i)
              hash["email"]=content.cell("B",i).to_s+"@cnpe.cc"
              hash["username"]=content.cell("B",i)
              category = Category.find_by("item_num=?",content.cell("C",i))
              hash["department_id"]=category.id
              gender = content.cell("F",i).to_s=="男" ? 1 : 2
              hash["gender"] = gender
             #hash["rank_id"]=
              hash["password"]= "123456"  #content.cell("H",i).to_s[-6,6]
              hash["is_approve"] = true
              puts hash.inspect
            u = User.new(hash)
          #  u.department = content.cell("C",i).to_i
            u.save
          # end
    	end
    	
   end
end
