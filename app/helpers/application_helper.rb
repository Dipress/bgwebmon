module ApplicationHelper
	def title_helper
		def_title = "Bgwebmon"
		@title.nil? ? def_title : "#{def_title} | #{@title}"
	end
	def li_menu(controllername, content)
		content_tag :li, content, class: (controller.controller_name.eql?(controllername) ? "active" : nil)
	end
end
