// app/assets/javascripts/channels/reservations.js

//= require cable
//= require_self
//= require_tree .

this.App = {};
App.cable = ActionCable.createConsumer();  

App.messages = App.cable.subscriptions.create('ReservationsChannel', {  
	received: function(data) {
		if ($('#'+data.seat).hasClass("selected")) {
			$('#'+data.seat).removeClass('selected')
		} else if ($('#'+data.seat).hasClass("deselected")){
			$('#'+data.seat).removeClass('deselected')
		} else { 
			$('#'+data.seat).toggleClass('disabled')
		}
	}

});