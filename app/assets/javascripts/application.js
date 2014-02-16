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
//
//= require jquery
//= require ./application/modernizr.js
//= require ./application/jquery-migrate-1.1.1.js
//= require ./superfish-1.4.8/hoverIntent.js
//= require ./superfish-1.4.8/superfish.js
//= require ./superfish-1.4.8/supersubs.js
//= require ./application/css3-mediaqueries.js
//= require ./application/nivoslider.js
//= require ./application/tabs.js

$(document).ready(function() {
	/*-----------------------------------------------------------------------------------*/
	/*	Dropdown menus - Superfish 
	/*-----------------------------------------------------------------------------------*/
	$(".sf-menu").superfish({ 
        animation: {height:'show'},   // slide-down effect without fade-in 
        delay:     200,               // 1.2 second delay on mouseout 
        autoArrows: false,
        speed: 150
    });
    
    
    /*-----------------------------------------------------------------------------------*/
    /*	Home Slider
    /*-----------------------------------------------------------------------------------*/
    $('#slider').nivoSlider({
		effect: 'random', // Specify sets like: 'fold,fade,sliceDown'
		animSpeed: 500, // Slide transition speed
        pauseTime: 3000, // How long each slide will show
        startSlide: 0, // Set starting Slide (0 index)
        controlNav: true, // 1,2,3... navigation
        directionNav: false, // Next & Prev navigation
	});
	
	/*-----------------------------------------------------------------------------------*/
	/*	ACCORDIONS
	/*-----------------------------------------------------------------------------------*/
	$('.accordion-container').hide(); 
	$('.accordion-trigger:first').addClass('active').next().show();
	$('.accordion-trigger').click(function(){
		if( $(this).next().is(':hidden') ) { 
			$('.accordion-trigger').removeClass('active').next().slideUp();
			$(this).toggleClass('active').next().slideDown();
		}
		return false;
	});
	
	/*-----------------------------------------------------------------------------------*/
	/*	TABS
	/*-----------------------------------------------------------------------------------*/
	$(".tabs").tabs("div.panes > div", {
    	// remove effect to prvent issues on ie
    });
    
	/*-----------------------------------------------------------------------------------*/
	/*	TOGGLE
	/*-----------------------------------------------------------------------------------*/
	$('.toggle-trigger').click(function() {
		$(this).next().toggle('slow');
		$(this).toggleClass("active");
		return false;
	}).next().hide();
	
	/*-----------------------------------------------------------------------------------*/
	/*	Scroll to top
	/*-----------------------------------------------------------------------------------*/
	$('.widget-cols .scroll').click(function(){
		$("html, body").animate({ scrollTop: 0 }, 600);
		return false;
	});
	
	/*-----------------------------------------------------------------------------------*/
    /*	MOBILE NAVIGATION
    /*-----------------------------------------------------------------------------------*/
    
    // Prepend combo nav holder
    $('nav').append('<div id="combo-holder"></div>');
    
    // Create the dropdown base
	$("<select id='comboNav' />").appendTo("#combo-holder");
	
	// Create default option "Go to..."
	$("<option />", {
		"selected": "selected",
		"value"   : "",
		"text"    : "Navigation"
	}).appendTo("#combo-holder select");
	
	// Populate dropdown with menu items
	$("#nav a").each(function() {
		var el = $(this);		
		var label = $(this).parent().parent().attr('id');
		var sub = (label == 'nav') ? '' : '- ';
		
		$("<option />", {
		 "value"   : el.attr("href"),
		 "text"    :  sub + el.text()
		}).appendTo("#combo-holder select");
	});
	
	/* Combo navigation action ----------------------------------------------------*/
	
	$("#comboNav").change(function() {
	  location = this.options[this.selectedIndex].value;
	});
});