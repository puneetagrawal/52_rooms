module Spree
	module ProductsHelper

		def get_option_value(id)   
			@option_value=Spree::OptionValue.find(id)
			return  @option_value.name 
		end
		
	end
end