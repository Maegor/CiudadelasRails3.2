
function center(){

	var windowWidth = $(document).width();
	var windowHeight = $(document).height();
	var popupHeight = $(".popupContainer").height();
    console.log(popupHeight);
	var popupWidth = $(".popupContainer").width();
	$(".popupContainer").css({
		"position": "fixed",
		"top": windowHeight/2-popupHeight/2,
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



$('#messages_icon').click(function (){


    if(currentPopup == ""){
        currentPopup = "messages_container";
        $("#"+currentPopup + ".hidden").fadeIn("slow");
        $("#"+currentPopup + " .popupContainer").fadeIn("slow");
        $("#"+currentPopup + ".closePopup").fadeIn("slow");
        $("#overlayEffect").fadeIn("slow");
        center(currentPopup);

    }

});




$('.action_icon').click(function (ev){


    if(currentPopup == ""){
        currentPopup = ev.currentTarget.id;
        $("#" + currentPopup + ".hidden").fadeIn("slow");
        $("#" + currentPopup + " .popupContainer").fadeIn("slow");
        $("#" + currentPopup + ".closePopup").fadeIn("slow");
        $("#overlayEffect").fadeIn("slow");
        center(currentPopup);

}

});

    $(".closePopup").click(function(){
        hidePopup();
    });


    function hidePopup(){

        if(currentPopup != ""){
            $("#" + currentPopup + ".hidden").fadeOut("slow");
            $("#close").fadeOut("slow");
            $("#overlayEffect").fadeOut("slow");
            currentPopup = "";
        }
    }


    function center(currentPopup){


        var container =  $("#" + currentPopup + " .popupContainer");
        var windowWidth = $(document).width();
        var windowHeight = $(document).height();

        var popupHeight = container.height();
        var popupWidth =  container.width();


        container.css({
            "position": "fixed",
            "top": windowHeight/2-popupHeight/2,
            "left": windowWidth/2-popupWidth/2
        });

    }

});

