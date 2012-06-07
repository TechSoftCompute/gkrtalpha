# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

yourFunction = ->
	myURL = parseURL(document.URL)
	if $("#step").attr('rel') != "-1"
	  $.ajax '/fewmoreproducts'
	    data: "step="+ $("#step").attr('rel')+"&"+ myURL.params["order"],
	    type: "GET"
	  true
  else
  	false
	
$("ul#products").nearBottom {
  callback: yourFunction,
  delay: 1000,
  pixelsFromBottom: 100
}

