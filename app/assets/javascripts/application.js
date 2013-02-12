// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//= require jquery
//= require jquery_ujs
//= require_directory ./store

/*
$(function() {
	$("span#bcountry select#order_bill_address_attributes_country_id").live('click',function() {
    	console.log($(this).val()); 
    	
   	});
   	
});
*/


/*


$(function() {




	get_states = function(region) {
      return state_mapper[country_from_region(region)];
    };



	update_state = function(region) {
      var selected, state_input, state_para, state_select, state_span_required, states, states_required, states_with_blank;
      states = get_states(region);
      states_required = get_states_required(region);
      state_para = $('p#' + region + 'state');
      state_select = state_para.find('select');
      state_input = state_para.find('input');
      state_span_required = state_para.find('state-required');
      if (states) {
        selected = parseInt(state_select.val());
        state_select.html('');
        states_with_blank = [['', '']].concat(states);
        $.each(states_with_blank, function(pos, id_nm) {
          var opt;
          opt = ($(document.createElement('option'))).attr('value', id_nm[0]).html(id_nm[1]);
          if (selected === id_nm[0]) {
            opt.prop('selected', true);
          }
          return state_select.append(opt);
        });
        state_select.prop('disabled', false).show();
        state_input.hide().prop('disabled', true);
        return state_span_required.show();
      } else {
        state_select.hide().prop('disabled', true);
        state_input.show();
        if (states_required) {
          state_span_required.show();
        } else {
          state_input.val('');
          state_span_required.hide();
        }
        state_para.toggle(!!states_required);
        return state_input.prop('disabled', !states_required);
      }
    };


	$("span#bcountry select#order_bill_address_attributes_country_id").live('click',function() {
    	console.log($(this).val()); 
    	return update_state('b');
   	});


	$("span#scountry select#order_ship_address_attributes_country_id").live('click',function() {
    	console.log($(this).val()); 
    		
   	});
	update_state('b');
    update_state('s');
   	
});

*/


$(function() {

	var countryid;
	$("span#bcountry select#order_bill_address_attributes_country_id").live('click',function() {
    	countryid = $(this).val();
    	console.log(countryid);
    	// get_states(); 
   	});


	$("span#scountry select#order_ship_address_attributes_country_id").live('click',function() {
    	console.log($(this).val()); 
    	
   	});



   	get_states=function(){  
  		var room_type_all = [1, 2, 3]
  		$.ajax({
	    	url: "/get_states",
	    	data: {
	      		"country_id": countryid
	   	 	}
	   	})
	}
   	
});
