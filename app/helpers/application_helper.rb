module ApplicationHelper
	def title_helper
		def_title = "Bgwebmon"
		@title.nil? ? def_title : "#{def_title} | #{@title}"
	end
end
