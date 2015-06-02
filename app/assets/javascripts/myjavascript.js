
$(document).on('ready page:load', function () {

	// movie show
	$('.star-rating-show').raty({
	    path: '/assets/',
	    readOnly: true,
	    score: function ( ) {
	      return $(this).attr('data-number');
    	}
  	})

	// review form 
	$('#star-rating-form').raty( {
	    path: '/assets/',
	    scoreName: 'review[rating]'
	})

	// review edit
	$('#star-rating-edit').raty( {
	    path: '/assets/',
	    score: function ( ) {
	      return $(this).attr('data-number');
	    },
	    scoreName: 'review[rating]'
  	})

});