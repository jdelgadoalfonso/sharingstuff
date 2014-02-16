$(document).ready(function() {
  var myApp = (function() {
	
	var userForm = $('#new_user');
	
	var subirImagen = function() {
		userForm.attr('action', '/auth/sharingstuff/callback/true');
		userForm.submit();
	}
	
  	var object = {
  		'submitButton': $('#submitButton').click(function() {
  			userForm.attr('action', '/auth/sharingstuff/callback/false');
  			userForm.submit();
		}),
		'eliminarAvatar': $('#eliminarAvatar').click(function() {
			$('avatar').val('');
			subirImagen();
		}),
		'subirImagen': $('#avatar').live('change', subirImagen)
  	};
  	return object;
  })();
});