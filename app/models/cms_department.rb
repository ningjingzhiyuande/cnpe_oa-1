class CmsDepartment < ActiveRecord::Base
	enum kind: [:bumenjieshao,:zuzhijiegou,:yewufanwei,:renyuanxinxi,:tuanduijianshe,:about_us]
	
end
