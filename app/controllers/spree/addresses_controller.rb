#AddressesController.class_eval do
AddressessController.class_eval do

	def get_state

		 #@states_array = Array.new
		 @country_name=params[:country_name]

		 @state_data = ["1","2","3"]      #spree_states.where("country_id=?",params[:country_name]);



		 #states_array<< {:states_names=>state_data } 
	end
end