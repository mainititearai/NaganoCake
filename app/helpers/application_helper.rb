module ApplicationHelper

	def resource_name
   	:member
	end

	def resource
	   @resource ||= Member.new
	end

	def devise_mapping
	   @devise_mapping ||= Devise.mappings[:member]
end

  def converting_to_jpy(price)
    "#{price.to_s(:delimited, delimiter: ',')}"
  end

end
