module ApplicationHelper

	def rest_days
	   str = []
      dates = DateSetting.where("work_status=?",DateSetting.work_statuses["rest"]).order("year desc")
      dates.map{|d|str.push(d.data)}
      str.join(",")
	end
	def work_days
	   str = []
      dates = DateSetting.where("work_status=?",DateSetting.work_statuses["work"]).order("year desc")
      dates.map{|d|str.push(d.data)}
      str.join(",")
	end

	def coustom_devise_message

  return "" if resource.errors.empty?

  messages = resource.errors.full_messages.map { |msg| content_tag(:span, msg) }.join(",")
  sentence = I18n.t("errors.messages.not_saved",
                    count: resource.errors.count,
                    resource: resource.class.model_name.human.downcase)

  html = <<-HTML


    <div>错误：#{messages}</div>

  HTML

  html.html_safe

	end

end
