
function UomData(data) {
    this.data;
    if (data === undefined) {
        this.data = [];
    } else {
        this.data = data;
    }
}

UomData.prototype = {
    constructor: UomData,

    add: function(d) {
        this.data.push(d);
    },

    get: function() {
        return Object.assign([], this.data);
    },

    remove: function(id) {
        for (var i=0; i<this.data.length; i++) {
            if (parseInt(this.data[i].id) == parseInt(id)) {
                this.data.splice(i, 1);
                break;
            }
        }
    },

    contains: function(id) {
        for (var i=0; i<this.data.length; i++) {
            if (parseInt(this.data[i].id) == parseInt(id)) {
                return true;
            }
        }
        return false;
    },

    generate_options: function() {
        var buff = "";

        for (var i=0; i<this.data.length; i++) {
            buff += '<option value="'+ this.data[i].id +'">'+ this.data[i].name +'</option>';
        }
        return $(buff);
    },

    size: function(){
        return this.data.length;
    }

}

