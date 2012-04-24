module EventsHelper

	def render_field(event, field)
		render( :template => "events/_field_form.html.erb", :locals => {:event => event, :field => field })
	end

end
