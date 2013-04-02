
function center(){

	var windowWidth = $(document).width();
	var windowHeight = $(document).height();
	var popupHeight = $(".popupContainer").height();
	var popupWidth = $(".popupContainer").width();
	$(".popupContainer").css({
		"position": "absolute",
		"top": windowHeight/4-popupHeight/2,
		"left": windowWidth/2-popupWidth/2
	});
	
	}


function loadPopup(){
    $(".popupContainer").fadeIn("slow");
    $(".closePopup").fadeIn("slow");
    center();
}

$(function (){

var currentPopup= "";

$('.action_icon').click(function (ev){

         console.log(currentPopup);
    if(currentPopup == ""){
        currentPopup = ev.currentTarget.id
        $("#" + ev.currentTarget.id + ".hidden").fadeIn("slow");
        $("#" + ev.currentTarget.id + "  .popupContainer").fadeIn("slow");
        $("#" + ev.currentTarget.id + ".closePopup").fadeIn("slow");
        console.log(currentPopup);
        center(currentPopup);

}

});

    $(".closePopup").click(function(){
        console.log("cllss");
        hidePopup();
    });


    function hidePopup(){
        console.log(currentPopup);
        if(currentPopup != ""){

            $("#" + currentPopup + ".hidden").fadeOut("slow");
            $("#close").fadeOut("slow");
            currentPopup = "";
        }
    }


    function center(){
        console.log("center");
        var windowWidth = $(document).width();
        var windowHeight = $(document).height();
        var popupHeight = $(".popupContainer").height();
        var popupWidth =  $(".popupContainer").width();
        $(".popupContainer").css({
            "position": "absolute",
            "top": windowHeight/4-popupHeight/2,
            "left": windowWidth/2-popupWidth/2
        });

    }




});

