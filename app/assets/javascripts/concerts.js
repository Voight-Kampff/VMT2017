document.addEventListener("turbolinks:load", (align_height));

$(window).resize(align_height);

function align_height() {

	cards = $(".counter")

	cards.each(function (index,value){
		if (index % 2 == 0) {
		// do nothing
		} else {
		var i  = index;

		// for the title
		var id = "#card_title_span_"+i;
		var id_inc_neg = "#card_title_span_"+(i-1);
		var height= Math.max($(id).height(),$(id_inc_neg).height());
		var id = "#outer_card_title_"+i;
		var id_inc_neg = "#outer_card_title_"+(i-1);
		$(id).height(height)
		$(id_inc_neg).height(height)

		// for the sub title
		var id = "#card_subtitle_"+i;
		var id_inc_neg = "#card_subtitle_"+(i-1);
		var height= Math.max($(id).height(),$(id_inc_neg).height());
		var id = "#outer_card_subtitle_"+i;
		var id_inc_neg = "#outer_card_subtitle_"+(i-1);
		$(id).height(height)
		$(id_inc_neg).height(height)
		}
	})

 }

//

function SlideOut(target,side){

}



function revealSeatPlan(counter) {
	var target = getInflatableTarget(counter)
	if (getInflatableTarget(counter) == "#"+$("#seat-plan").parent().attr('id')) {
		$("#seat-plan").css({"transform" : "translateX(-150%)"});
		setTimeout(function(){
			depopulatePlan();
			populatePlan(free_seats)
			$("#seat-plan").css({"transform" : "translateX(-0%)"})
		},1600)
	}
	else {
			hideSeatPlan()
		// if ($("#seat-plan").hasClass("deployed")) {
		// 	$("#seat-plan").removeClass("deployed")
		// 	$("#seat-plan").css({"transform" : "translateX(-150%)"});
		// 	setTimeout(function(){
		// 		$("#seat-plan").hide();
		// 		$("#seat-plan").parent().slideUp(600);
		// 		depopulatePlan();
		// 	},1600)
		// }

		setTimeout(function(){
			
			$("#seat-plan").addClass("deployed")
			$("#seat-plan").detach().appendTo(target)
			populatePlan(free_seats);
			$("#seat-plan").show();
			$(target).slideDown(600, function() {
			$("#seat-plan").css({"transform" : "translateX(-0%)"});
			$([document.documentElement, document.body]).animate({
				scrollTop: $("#seat-plan").offset().top-100,}, 800);
			})
		},1600)
	}

}

function slideCard (target,translation){
	$(target).css({"transform" : "translateX("+translation+")"});
}

function populatePlan(array){
	$("#name").text(name)
	$("#dateloc").text(dateloc)
	$('#catA_seat_price').text(catAprice)
	$('#catB_seat_price').text(catBprice)
	$.each (free_seats,function (index,value) {
		$("#"+array[index]).removeClass("disabled")
		$("#"+array[index]).addClass("active")
	})
}﻿

function depopulatePlan(){
	$(".active").addClass("disabled")
	$(".active").removeClass("active")
	}

const transition = document.querySelector('.transition');

function revealBasket(){
	// Partial panel hide
	$("#seat-plan").css({"transform" : "translateX(-150%)"})
	$("#seat-plan").removeClass("deployed")
	$("#basket-card").addClass("deployed")
	setTimeout(function(){
		$("#basket-card").detach().appendTo($("#seat-plan").parent());
		$("#seat-plan").detach().prependTo($('main'))
		$("#basket-card").show()
		$("#seat-plan").hide()
		$("#basket-card").css({"transform" : "translateX(0%)"})
	},1600)
}

function hideSeatPlan() {
	if ($("#seat-plan").hasClass("deployed")) {
			$("#seat-plan").removeClass("deployed")
			$("#seat-plan").css({"transform" : "translateX(-150%)"});
			setTimeout(function(){
				$("#seat-plan").hide();
				$("#seat-plan").parent().slideUp(600);
				depopulatePlan(free_seats);
				$("#seat-plan").detach().prependTo('main')
			},1600)
		}

		//code could be refactored into a universal function
	else if ($("#basket-card").hasClass("deployed")){
			$("#basket-card").removeClass("deployed")
			$("#basket-card").css({"transform" : "translateX(150%)"});
			setTimeout(function(){
				$("#basket-card").hide();
				$("#basket-card").parent().slideUp(600);
				//depopulate basket if necessairy
				$("#basket-card").detach().prependTo('main')
			},1600)
	}
}

function getInflatableTarget(target){

	//Large
	if ($('header').width() <= 600){
		var target = "#inflatable-container_"+target
	}
	
	//Medium
	else if ($('header').width() > 600 && $('header').width() < 992){
		var target = "#inflatable-container_"+(((target / 2) >> 0)+1)
	}

	else
		var target = "#inflatable-container_"+(((target / 3) >> 0)+2)

	//Small

	return target

}



