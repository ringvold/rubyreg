module ApplicationHelper

	# Return "active" if the current path is the 
  # same as the path given as parameter
	# Is used for the main menu
	def is_active?(path)
	  "active" if current_page?(path)
	end	

	# Alternative method. Checks only action name.
	# def is_active?(page_name)
 	#    "active" if params[:action] == page_name
 	#  end

end
