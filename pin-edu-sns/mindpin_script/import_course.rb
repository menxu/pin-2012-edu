# 该脚本用来导入 课程
# 在工程根目录运行
# rails runner script/script/import_course.rb /xxx/data.csv

require "csv"

path = ARGV[0]
raise "需要指定csv 文件路径" if path.blank?
raise "#{path} 不是一个有效的文件路径" if !File.exists?(path)

ActiveRecord::Base.transaction do
  
  raw_count = 0
  CSV.open(path, 'r') do |row|
    raw_count+=1
    
    begin
      name = row[0]
      cid = row[1]
      department = row[2]
      location = row[3]
      desc = row[4]
      
      course = Course.new(
        :name => name,
        :cid => cid,
        :department => department,
        :location => location,
        :desc => desc
      )
      course.save!
    rescue Exception=>ex
      raise "第 #{raw_count}行解析出错,本次操作已经回滚"
    end
    
  end
end