
/*function go_to_adress(adress) {
    window.location = adress;
}*/


function Hotkeys() {
    //this.Actions = new ActionsHelper();
    //this.Helper = new HotkeysHelper();
    //this.actions = {};
    this.init();
}

Hotkeys.prototype = {
    constructor: Hotkeys,
    
    init: function() {
        this.switch_page();
        //this.load_actions();
        //this.attach_event_handler();
    },

    /*load_actions: function() {
        this.switch_page();
    },*/

    /*attach_event_handler: function() {
        var cache = [];
        var totok = this;
        document.onkeydown = function(e) {
            //console.log(e.which);
            //console.log(e.ctrlKey);
            cache.push(e.which);
        }

        document.onkeyup = function(e) {
            //console.log(e.which);
            //console.log(e.ctrlKey);
            //cache.push(e.which);

            alert(cache);
            console.log(totok.actions);

            totok.actions['2']();
            cache = [];
        }
    },*/

    switch_page: function() {

        // anglicke klavesy, tato bola v original js prepisana
        $(document).key('ctrl+;', function() {
            window.location = '/';
        });

        $(document).key('ctrl+1', function() {
            window.location = '/goodsdb';
        });

        $(document).key('ctrl+2', function() {
            window.location = '/manufacturersdb';
        });

        $(document).key('ctrl+3', function() {
            window.location = '/localtaricdb';
        });

        /*var actions = {
            '1': '/',
            '2': '/goodsdb',
            '3': '/manufacturersdb',
            '4': '/localtaricdb'
        };*/

        

        //console.log(this.HELPER.get_keys_string(actions));

        //$(document).key(this.HELPER.get_keys_string(actions), function(e) {
            //window.location = actions[k];
            //console.log(e);
        //});

        /*for (var k in actions) {
            // skip loop if the property is from prototype
            if (!actions.hasOwnProperty(k)) continue;
            //var obj = actions[k];

            //console.log(actions[k]);

            //this.Actions.add(k, function() { console.log(actions[k]); console.log('runned'); });

            this.actions[''+k] = function() { console.log(actions[k]); console.log('runned'); };

            //$(document).key(k, function(e) {
                //window.location = actions[k];
                //console.log(k);
            //});
            
        }*/

        /*console.log(this.Actions.actions);*/
    }
}

/*function HotkeysHelper() { 
    this.keys_special = [16, 17, 91, 18, 225, 92];
    // lshift, lctrl, lwin, lalt, ralt, rwin, (ctrl opak.), (shift opak)
    //this.keys = 
}

HotkeysHelper.prototype = {
    constructor: HotkeysHelper,

    get_keys_string: function(actions) {
        return Object.keys(actions).join(',');
    },

    get_keys: function(actions) {
        return Object.keys(actions);
    },

    is_special_key: function(keycode) {
        return this.keys_special.includes(keycode);
    }
}*/

/*function ActionsHelper() { 
    //this.actions = [];
    this.actions = {};
}*/

/*ActionsHelper.prototype = {
    constructor: ActionsHelper,
    // action name - vlastne klavesova skratka v ludskej podobe

    add: function(action_name, fx) {
        //var action = {};
        this.actions[action_name] = fx;
        //this.actions.push(action);
    },

    run: function(action_name) {
        console.log(this.actions[action_name]);
        this.actions[action_name]();
    }
    
}*/
