
function UomData() {
    var data = [];

    this.add = function(d) {
        data.push(d);
    }

    this.get = function() {
        return data;
    }

    this.remove = function(id) {
        for (var i=0; i<data.length; i++) {
            if (parseInt(data[i].id) == parseInt(id)) {
                data.splice(i, 1);
                break;
            }
        }
    }
}

UomData.prototype = {
    constructor: UomData,

    contains: function(id) {
        var data = this.get();
        for (var i=0; i<data.length; i++) {
            if (parseInt(data[i].id) == parseInt(id)) {
                return true;
            }
        }
        return false;
    },

    generate_options: function() {
        var buff = "";
        var data = this.get();
        for (var i=0; i<data.length; i++) {
            buff += '<option value="'+ data[i].id +'">'+ data[i].name +'</option>';
        }
        return $(buff);
    },

    size: function(){
        return this.get().length;
    }

}

