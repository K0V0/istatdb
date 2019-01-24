function RememberLastSearches() {
	this.maxlength = 20;
    this.init();
}

RememberLastSearches.prototype = {
    constructor: RememberLastSearches,

    init: function() {
        //console.log("init");
        if (window['last_searches'] === undefined) {
        	window['last_searches'] = [];
            window['last_searches_pos'] = [];
        }
    },

    init_obj: function(ref) {
    	var varname = ref.closest('body').data('controller_name_singular');
    	if (window['last_searches'][varname] === undefined) {
    		window['last_searches'][varname] = [];
            window['last_searches_pos'] = [];
    	}
    	return varname;
    },

    add: function(ref) {
    	var varname = this.init_obj(ref);
    	var content = ref.val();
    	if (window['last_searches'][varname].includes(content)) {
    		// neopakovat vysledky
    		var pos = window['last_searches'][varname].indexOf(content);
    		window['last_searches'][varname].splice(pos, 1);
    		// priradene na zaciatok bude v dalsom kroku
    	}
    	if (window['last_searches'][varname].length > this.maxlength) {
    		window['last_searches'][varname].pop();
    	} 
    	window['last_searches'][varname].unshift(content);
        window['last_searches_pos'][varname] = 0;
    	//console.log(window['last_searches'][varname]);
    },

    rewind: function(ref) {
        // len pokial nie na konci, potom je undefined
        // implementovat potom od zaciatku ?
        var varname = this.init_obj(ref);
        var pos = window['last_searches_pos'][varname];
        var content = window['last_searches'][varname][pos];
        window['last_searches_pos'][varname]++;
        return content;
    }
}
