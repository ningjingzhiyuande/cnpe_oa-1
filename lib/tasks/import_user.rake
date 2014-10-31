require 'spreadsheet'
namespace :user do
	
   desc 'import user' 
   task :import => :environment do 

    	#puts  "导入用户的文件地址(绝对的地址)\n"
    	 ActiveRecord::Base.connection.execute("truncate users")
    	#file =  STDIN.gets.chomp
    	file =  "#{Rails.root}/public/user.xls"
    	content = Roo::Spreadsheet.open(file)
    	#binding.pry
    	(2..560).to_a.each do |i|
           hash={}
          # ["A","B","C","H"].each do |col|
              next if content.cell("K",i).nil?
              hash["name"]=content.cell("B",i)
              hash["email"]=content.cell("K",i).to_s+"@cnpe.cc"
              hash["username"]=content.cell("K",i)
              #category = Category.find_by("item_num=?",content.cell("C",i))
              category = Category.where("name like ?","#{content.cell("C",i)[0..2]}%").first
              next unless category
              hash["department_id"]=category.id
              gender = content.cell("F",i).to_s=="男" ? 1 : 2
              hash["gender"] = gender
             #hash["rank_id"]=
              hash["password"]= "123456"  #content.cell("H",i).to_s[-6,6]
              hash["is_approve"] = true
              hash["is_admin"] = true if content.cell("K",i)=="wangcw"
              puts hash.inspect
            u = User.new(hash)
          #  u.department = content.cell("C",i).to_i
            u.save
          # end
    	end
    	
   end
end

namespace :cnpe do
   desc 'truncate db' 
   task :truncate => :environment do 
          ActiveRecord::Base.connection.execute("truncate leaves")
          ActiveRecord::Base.connection.execute("truncate leave_details")
   end

end
