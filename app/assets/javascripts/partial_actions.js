/**
 * Created with JetBrains RubyMine.
 * User: molero
 * Date: 22/04/13
 * Time: 20:36
 * To change this template use File | Settings | File Templates.
 */



function build_severals(coins, cost_hash){

$('.image-checkbox-container div').on('click', function(){
    var  check = $(this).prev('input[type="checkbox"]');

    if(!check.attr("disabled")) {
        if(!check.prop('checked') ){
            check.prop('checked', true).attr('checked','checked');
            this.style.border = '4px solid #38A';
            this.style.margin = '0px';
            coins = coins - cost_hash[check.val()]

        }else{
            check.prop('checked', false).removeAttr('checked');
            this.style.border = '0';
            this.style.margin = '4px';
            coins = coins + cost_hash[check.val()]
        }


        var bol = $("input[type=checkbox][name='cards[]']:checked").length >= 3;


        if (bol){
            var unchecked_checks = $("input[type=checkbox][name='cards[]']").not(":checked");
            unchecked_checks.attr("disabled",bol);


        }else{

            $("input[type=checkbox][name='cards[]']").not(":checked").each(function() {

                var bol =  (coins - cost_hash[$(this).val()] < 0);
                $(this).attr("disabled",bol);

            })
        }
    }
});

}



function tabs (container_id){

    $('.tab').click(function(ev){


        if ($(ev.currentTarget).hasClass("unselected")){
            var option = $($(ev.currentTarget));
            var no_option = $( '#' + container_id + ' .tab.selected');
            var hidden = option.next();
            var visible = $('#' + container_id + ' .visible');

            option.removeClass("unselected");
            option.addClass("selected");
            no_option.removeClass("selected");
            no_option.addClass("unselected");

            hidden.removeClass("hidden");
            hidden.addClass("visible");
            visible.removeClass("visible");
            visible.addClass("hidden");
        }


    })



}