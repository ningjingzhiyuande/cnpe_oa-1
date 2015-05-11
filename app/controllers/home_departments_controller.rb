class HomeDepartmentsController < HomeController
	layout "cms"
  def show
  	 @item  = CmsDepartment.where("kind=?",CmsDepartment.kinds[params[:kind]]).first
  end
end
