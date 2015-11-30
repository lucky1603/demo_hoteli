$(document).ready(function(){
    var next = 1;
    $(".add-more").click(function(e){
        e.preventDefault();
        var addto = "#field" + next;
        var addRemove = "#field" + (next);
		var valTo = "#val" + next;

        next = next + 1;
        var newIn = '<input autocomplete="off" class="input form-control" id="field' + next + '" name="field' + next + '" type="text">';
		var newVal = '<input autocomplete="off" class="input form-control" id="val' + next + '" name="val' + next + '" type="text">';
        var newInput = $(newIn);
		var newValue = $(newVal);
        var removeBtn = '<button id="remove' + (next - 1) + '" class="btn btn-danger remove-me" >-</button></div><div id="field">';
        var removeButton = $(removeBtn);
        $(addto).after(newValue);
		newValue.after(newIn);
        $(addRemove).after(removeButton);
		$("#val" + next).attr('data-source',$(valTo).attr('data-source'));
        $("#field" + next).attr('data-source',$(addto).attr('data-source'));
        $("#count").val(next);  
        
            $('.remove-me').click(function(e){
                e.preventDefault();
                var fieldNum = this.id.charAt(this.id.length-1);
                var fieldID = "#field" + fieldNum;
				var valId = "#val" + fieldNum;
                $(this).remove();
                $(fieldID).remove();
				$(valId).remove();
            });
    });
});