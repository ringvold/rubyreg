module EventsHelper

	def render_field(event, field, rand_id = nil)
		render( :template => "events/_field_form",  :formats=>[:html], :handlers=>[:erb],:locals => {:event => event, :field => field, :rand_id => rand_id })
	end

end
