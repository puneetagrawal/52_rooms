

$(document).ready(function(){

$('ul.menu').delegate('li:not(.active)', 'click', function(e) {
   $(this).addClass('active').siblings().removeClass('active')
    .parents('div.homeMenuDetail').find('div.homeContent').find('div.box visible').hide().eq($(this).index()).fadeIn(0);
    e.preventDefault();
});

$('#prev').click(function(){
$('ul.menu').find('li.active').removeClass('active').prev().addClass('active');

});
$('#next').click(function(){
$('ul.menu').find('li.active').removeClass('active').next().addClass('active');
});

});


    $(function() {
        $( "#from" ).datepicker({
            changeMonth: true,
            numberOfMonths: 1,
            onClose: function( selectedDate ) {
                $( "#to" ).datepicker( "option", "minDate", selectedDate );
            }
        });
        $( "#to" ).datepicker({
            changeMonth: true,
            numberOfMonths: 1,
            onClose: function( selectedDate ) {
                $( "#from" ).datepicker( "option", "maxDate", selectedDate );
            }
        });
		
		$('.btn').click(function(){
			$(this).toggleClass('open');
			$(".btn li").click(function(){
				$(this).parent('ul').parent('a.dropdown-toggle').find("p").text($(this).text());
			});
		});
		
		$('.clear_date').click(function(){
			$('#from').val('Arrival Date');
			$('#to').val('Departure Date');
		});
		
    });
