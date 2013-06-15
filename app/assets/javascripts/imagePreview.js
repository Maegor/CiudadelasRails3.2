/*
 * Image preview script 
 * powered by jQuery (http://www.jquery.com)
 * 
 * written by Alen Grakalic (http://cssglobe.com)
 * 
 * for more info visit http://cssglobe.com/post/1695/easiest-tooltip-and-image-preview-using-jquery
 *
 */
 
function imagePreview(){
	/* CONFIG */
		
		//var xOffset = 10;
		//var yOffset = -30;
		
		// these 2 variable determine popup's distance from the cursor
		// you might want to adjust to get the right result
		
	/* END CONFIG */
	$(".preview").hover(function(e){
		this.t = this.title;
		this.title = "";
		var c = (this.t != "") ?  this.t : "";
		$("#tablero").append("<div id='preview'><img  width='200' height='312' src='../../assets/cards/hd/"+ $(this).attr('id') +
            ".png' alt='Image preview' />" +
            "<div class='preview_description'>"+ c +"</div>" + "</div>");
		$("#preview")
			.css("top",(e.pageY - yOffSet(e)) + "px")
			.css("left",(e.pageX + xOffSet(e)) + "px")
            .css("position", "absolute")

			.fadeIn("slow");
    },
	function(){
		this.title = this.t;	
		$("#preview").remove();
    });	
	$(".preview").mousemove(function(e){
		$("#preview")
			.css("top",(e.pageY - yOffSet(e)) + "px")
			.css("left",(e.pageX + xOffSet(e)) + "px");
	});


    function xOffSet(e) {
        var boardWith = $(document).width();
        var offset = 0;
        if (e.pageX >= (boardWith / 2)) {
            offset = -230;
        } else {
            offset = 20;
        }
        return offset;
    }
    function yOffSet(e) {
        var boardWith = $(document).height();
        var offset = 0;
        if (e.pageY >= (boardWith / 2)) {
            offset = 320;
        } else {
            offset = 10;
        }
        return offset;
    }



};


// starting the script on page load
$(document).ready(function(){
	imagePreview();
});