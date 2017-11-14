$(function() {
  window.t = function(key) {
    if(!key){
      return "N/A";
    }
    
    var keys = key.split(".");
    var comp = window.I18n;
    $(keys).each(function(_, value) {
      if(comp){
        comp = comp[value];
      }
    });

    if(!comp && console){
      console.debug("No translation found for key: " + key);
      return "N/A";
    }

    return comp;
  };
});