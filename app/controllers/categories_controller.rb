class CategoriesController < AdminController
	load_and_authorize_resource
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
  	@kind = params[:kind] || "dept"
    @categories = Category.where("kind=?",Category.kinds[@kind])
    @category = (Category.find_by_id params[:c_id]) || Category.new
    respond_with(@categories)
  end

  def show
    respond_with(@category)
  end

  def new
    @category = Category.new
    respond_with(@category)
  end

  def edit
  end

  def create
    @category = Category.new(category_params)
    @category.user_id = current_user.id
    flash[:notice] = "成功添加" if @category.save
    respond_with(@category, :status => :created, :location => "/categories/kind/#{@category.kind}")
  end

  def update
  	@category.user_id = current_user.id
    @category.update(category_params)
    flash[:notice] = "修改成功"
    respond_with(@category, :status => :created, :location => "/categories/kind/#{@category.kind}")
  end

  def destroy
    @category.destroy
    flash[:notice] = "成功删除"
    respond_with(@category)
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:kind, :item_num, :name, :info, :position, :status)
    end
end
