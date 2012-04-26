module EventsHelper

	def render_field(event, field)
		render( :template => "events/_field_form",  :formats=>[:html], :handlers=>[:erb],:locals => {:event => event, :field => field })
	end

end
