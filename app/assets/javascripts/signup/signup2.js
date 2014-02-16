$(document).ready(function() {
  var myApp = new function() {
	
	var stuffForm = $('#new_stuff');
	
	var progressHandlingFunction = function(e) {
	    if (e.lengthComputable) {
	        $('progress').attr({
	        	value: e.loaded,
	        	max: e.total
	        });
	    }
	}
	
	var ordenar = function(catA, catB, opt_selected) {
		$(catA)
		.children(opt_selected)
		.each(function() {
			var $that = $(this);
			var movido = false;
			$(catB).children()
			.each(function() {
				if ($that.data('order') < $(this).data('order')) {
					$(this).before($that);
					movido = true;
					return false;
				}
			});
			if (!movido) {
				$(catB).append($(this));
			}
		});		
	};
	  
	var currentMarket = null;
 
  	var optionsDialogo = {
		'autoOpen': false,
		'modal':    true,
		'width':    650,
		'height':   550
	};
	var optionsMapa = {
		'center': new google.maps.LatLng(
			59.3426606750, 18.0736160278
		)
	};
  	var object = {
  		'optionsDialogo': optionsDialogo,
  		'optionsMapa': optionsMapa, 
  	 	'stuffForm': stuffForm.dialog(optionsDialogo),
  	 	'map': $("#map").gmap(optionsMapa)
  	 	.bind('init', function(event, map) { 
			$(map).click(function(event) {
				object.map.gmap('addMarker', {
					'position': event.latLng, 
					'draggable': true, 
					'bounds': false
				}, function(map, marker) {
					object.stuffForm.dialog('open');
					currentMarker = marker;
				}).dragend(function(event) {
					
				}).click(function() {
					object.stuffForm.dialog('open');
					currentMarker = this;
				}).mouseover(function(event) {
					object.map.gmap('openInfoWindow',
							{ 'content': 'TEXT_AND_HTML_IN_INFOWINDOW' },
							this); //TODO: put content
				}).mouseout(function(event) {
					object.map.gmap('closeInfoWindow');
				});
			})
		}),
		'quitarTodos': $('#quitarTodos').button().click(function() {
			ordenar('#categotiasIncluidas', '#categotiasNoIncluidas', '');
		}),
		'anadirTodos': $('#anadirTodos').button().click(function() {
			ordenar('#categotiasNoIncluidas', '#categotiasIncluidas', '');
		}),
		'quitarSeleccionados': $('#quitarSeleccionados').button().click(function() {
			ordenar('#categotiasIncluidas', '#categotiasNoIncluidas', ':selected');
		}),
		'anadirSeleccionados': $('#anadirSeleccionados').button().click(function() {
			ordenar('#categotiasNoIncluidas', '#categotiasIncluidas', ':selected');
		}),
  		'okButton': $('#ok').button().click(function() {
			object.stuffForm.dialog('close');
  		    var formData = new FormData(stuffForm[0]);
  		    $.ajax({
  		        url: 'upload.php',  //Server script to process data
  		        type: 'POST',
  		        xhr: function() {  // Custom XMLHttpRequest
  		        	var myXhr = $.ajaxSettings.xhr();
  		        	if (myXhr.upload) { // Check if upload property exists
  		        		myXhr.upload.addEventListener(
  		        				'progress',
  		        				progressHandlingFunction,
  		        				false); // For handling the progress of the upload
  		        	}
  		        	return myXhr;
  		        },
  		        //Ajax events
  		        //beforeSend: beforeSendHandler,
  		        //success: completeHandler,
  		        //error: errorHandler,
  		        // Form data
  		        data: formData,
  		        //Options to tell jQuery not to process data or worry about content-type.
  		        cache: false,
  		        contentType: false,
  		        processData: false
  		    });
			currentMarker = null;
		}),
  		'cancelButton': $('#cancel').button().click(function() {
			object.stuffForm.dialog('close');
			currentMarker.setMap(null);
			// TODO: limpiar el formulario
		}),
		'inputLugar': $('#lugar').geocomplete()
		.bind("geocode:result",
			function(event, result) {
				object.map.gmap('option', 'center', result.geometry.location);
				var map = object.map.gmap('get', 'map');
				try {
					map.fitBounds(result.geometry.viewport);
				} catch (e) {
					object.map.gmap('option', 'zoom', 15);
				}
			}
  		)
  	};
  	return object;
  };
});