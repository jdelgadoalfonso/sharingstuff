$(document).ready(function() {
  var myApp = (function() {
  	var opt = {
		collapsible: true
	};
  	var object = {
  		opt: opt,
  	 	accordion: $('#accordion').accordion(opt)
  	};
  	return object;
  })();
});