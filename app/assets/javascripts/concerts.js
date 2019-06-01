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