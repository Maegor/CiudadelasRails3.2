
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
        $("#" + currentPopup + ".hidden").fadeIn("slow");
        $("#" + currentPopup + " .popupContainer").fadeIn("slow");
        $("#" + currentPopup + ".closePopup").fadeIn("slow");
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


    function center(currentPopup){


        container =  $("#" + currentPopup + " .popupContainer");
        var windowWidth = $(document).width();
        var windowHeight = $(document).height();

        var popupHeight = container.height();
        var popupWidth =  container.width();


        container.css({
            "position": "absolute",
            "top": windowHeight/4-popupHeight/2,
            "left": windowWidth/2-popupWidth/2
        });

    }

});

