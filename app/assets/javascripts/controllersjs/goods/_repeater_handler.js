function RepeaterHandler() {
    this.url = '';
    this.elem = null;
    this.init();
}

RepeaterHandler.prototype = {
    constructor: RepeaterHandler,

    init: function() {
        var totok = this;
        totok.elem = $(document).find('a#good_repeat_assignment');
        totok.url = totok.elem.attr('href');

        totok.inputChange(totok, $(document).find('input#good_ident'), 'item');
        totok.inputChange(totok, $(document).find('textarea#good_description'), 'description');

    	$(document).on('keyup', 'input#good_ident', function() {
            totok.inputChange(totok, this, 'item');
    	});

        $(document).on('keyup', 'textarea#good_description', function() {
            totok.inputChange(totok, this, 'description');
        });
    },

    editURLparameter: function(url, param, paramVal) {
        var newAdditionalURL = "";
        var tempArray = url.split("?");
        var baseURL = tempArray[0];
        var additionalURL = tempArray[1];
        var temp = "";
        if (additionalURL) {
            tempArray = additionalURL.split("&");
            for (var i=0; i<tempArray.length; i++){
                if(tempArray[i].split('=')[0] != param){
                    newAdditionalURL += temp + tempArray[i];
                    temp = "&";
                }
            }
        }

        var rows_txt = temp + "" + param + "=" + paramVal;
        return baseURL + "?" + newAdditionalURL + rows_txt;
    },

    inputChange: function(totok, dis, name) {
        totok.url = totok.editURLparameter(totok.url, name, $(dis).val());
        totok.elem.attr('href', totok.url);
    }
}
