(function(Rescousse, $) {
  "use strict";
  
  var labelRegExp1 = /\b(bar|pub|taverne|cabaret|(micro-?)?(brasserie|brewery)|caf(e|é)|rest(o|aurant))\b/gi;
  var labelRegExp2 = /\b(the|ye|les?|la|l|of|du|des?|d|my|y?our|mon|ma|mes|(n|v)otre|à|chez|at|\W+)\b/gi;
  function createLabel(name) {
    var label = name.replace(labelRegExp1, "").replace(labelRegExp2, "").trim();
    return label ? label[0].toUpperCase() : "·";
  }
  
  function escape(string) {
    return string.replace(/<.*?>|[/<>]+/g, "");
  }
  
  function InfoMarker(gmap, options) {
    $.extend(this.options, this.defaults, options);
    this.map = gmap;
    
    this.infowindow = new google.maps.InfoWindow();
    this.marker     = new google.maps.Marker({map: gmap});
  }
  InfoMarker.prototype = {
    show: function() {
      this.marker.setLabel({
        text: this._label,
        color: this.options.labelColor,
        fontWeight: "700"
      });
      this.marker.setVisible(true);
      
      if (this._content) {
        this.infowindow.setContent(
          (this._title ? "<h6 style='line-height: 16px;'>"+
                           this._icon + this._title +
                         "</h6>"
                       : "") + this._content
        );
        this.infowindow.open(this.map, this.marker);
      }
    },
    hide: function() {
      this.infowindow.close();
      this.marker.setVisible(false);
    },
    clear: function() {
      this.hide();
      this._label   = "×";
      this._icon    = "";
      this._title   = "";
      this._content = "";
      this._place   = undefined;
    },
    
    get position()      { return this.marker.getPosition(); },
    set position(value) { this.marker.setPosition(value); },
    
    get label()      { return this._label; },
    set label(value) { this._label = (value.length > 1) ? createLabel(value) : value; },
    
    get icon()       { return this._icon; },
    set icon(value)  {
      this._icon = value ? "<img src='"+ encodeURI(value) +"' width='16' height='16' />&nbsp;" : "";
    },
    
    get title()      { return this._title; },
    set title(value) { this._title = escape(value); },
    
    get content()      { return this._content; },
    set content(value) { this._content = escape(value); },
    
    get place() {
      return this._place;
    },
    set place(value) {
      this._place = value;
      this.clear();
      
      if (value.geometry) {
        this.position = value.geometry.location;
        this.label    = value.name;
        
        this.icon    = value.icon;
        this.title   = value.name;
        this.content = value.vicinity;
        
        if (this.options.autoShow) this.show();
      }
    },
    
    options: {},
    defaults: {
      autoShow: true,
      labelColor: "#FFF",
    }
  };
  
  Rescousse.InfoMarker = InfoMarker;
})(window.Rescousse = window.Rescousse || {}, jQuery);
