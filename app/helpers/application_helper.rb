module ApplicationHelper

	def avatar_url(user)
		gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
		default = "http://www.wpclipart.com/people/ethnic/tribal.png"
		"http://gravatar.com/avatar/#{gravatar_id}.png?s=48&d=#{CGI.escape(default)}"
	end

	def javascript(*files)
  		content_for(:head) { javascript_include_tag(*files) }
	end

	def stylesheet(*files)
  		content_for(:head) { stylesheet_link_tag(*files) }
	end
end
