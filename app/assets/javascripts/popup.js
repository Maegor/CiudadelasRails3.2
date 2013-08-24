﻿var currentPopup= "";
function center(){
    var popup = $(".popupContainer");
	var windowWidth = $(document).width();
	var windowHeight = $(document).height();
	var popupHeight = popup.height();
 	var popupWidth = popup.width();
    popup.css({
		"position": "fixed",
		"top": windowHeight/2-popupHeight/2,
		"left": windowWidth/2-popupWidth/2
            });

}


function loadPopup(popupToload){
    var  popup =  $("#" + popupToload);
    popup.fadeIn("slow");
   // $(".closePopup").fadeIn("slow");
    popup.find(".overlayEffect").fadeIn("slow");


    center();
}






 function AddListenerToButton(button){
     var messages_container = "messages_container";
     $('#' + button).click(function (){
         if(currentPopup == ""){
             currentPopup = messages_container;
             $("#"+messages_container + ".hidden").fadeIn("slow");
             $("#"+messages_container + " .popupContainer").fadeIn("slow");
             $("#"+messages_container + ".closePopup").fadeIn("slow");
             $("#overlayEffect").fadeIn("slow");

             center2(messages_container);
         }

       });
 }

function center2(currentPopup){


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





$(function (){


$('#messages_icon').click(function (){


    if(currentPopup == ""){
        currentPopup = "messages_container";
        $("#"+currentPopup + ".hidden").fadeIn("slow");
        $("#"+currentPopup + " .popupContainer").fadeIn("slow");
        $("#"+currentPopup + ".closePopup").fadeIn("slow");
        $("#"+currentPopup).find(".overlayEffect").fadeIn("slow");
        center(currentPopup);

    }

});




$('.action_icon').click(function (ev){


    if(currentPopup == ""){
        var icon_name = ev.currentTarget.id
        currentPopup = icon_name.substr(0,icon_name.length - 5);
        $("#" + currentPopup + ".hidden").fadeIn("slow");
        $("#" + currentPopup + " .popupContainer").fadeIn("slow");
        $("#" + currentPopup + ".closePopup").fadeIn("slow");
        $("#" + currentPopup).find(".overlayEffect").fadeIn("fast");
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

$.fn.textWidth = function(){
    var html_org = $(this).html();
    var html_calc = '<span>' + html_org + '</span>';
    $(this).html(html_calc);
    var width = $(this).find('span:first').width();
    $(this).html(html_org);
    return width;
};
