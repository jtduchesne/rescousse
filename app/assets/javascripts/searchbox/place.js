(function(Rescousse, $) {
  "use strict";
  
  var locale = document.documentElement.lang;
  var components = ['country','province','city','hood','street'];
  
  function Place(options) {
    options = options || {};
    $.extend(this.restrictions, this.defaults.restrictions, options.restrictions);
    $.extend(this.messages, this.defaults.messages, options.messages);
  }
  Place.prototype = {
    set: function(gplace) {
      $.extend(this, gplace);
      this._valid = !!gplace.geometry;
      
      var self = this;
      gplace.address_components.forEach(function(c) {
        switch(c.types[0]) {
        case 'street_number':
          self.number = c.long_name;
          break;
        case 'route':
          self.street = c.long_name;
          self.validate('street');
          break;
        case 'sublocality', 'sublocality_level_1':
          self.hood = c.long_name;
          self.validate('hood');
          break;
        case 'locality':
          self.city = c.long_name;
          self.validate('city');
          break;
        case 'administrative_area_level_1':
          self.province = c.short_name;
          self.validate('province');
          break;
        case 'country':
          self.country = c.short_name;
          self.validate('country');
          break;
        case 'postal_code':
          self.postcode = c.long_name;
          break;
        }
      });
      this.address = [this.number, this.street].filter(function(c) { return c; }).join(", ");
      
      return this;
    },
    
    validate: function(component) {
      return this._valid = this._valid && this.isValid(component);
    },
    
    isValid: function(component) {
      return (this.restrictions[component] === undefined) ||
             (this.restrictions[component].length === 0) ||
              this.restrictions[component].includes(this[component]);
    },
    isInvalid: function(component) {
      return !this.isValid(component);
    },
    
    get valid()   { return this._valid; },
    get invalid() { return !this._valid; },
    
    getMessage: function() {
      var component = components.find(this.isInvalid.bind(this));
      return this.messages[component] && this.messages[component][locale];
    },
    
    restrictions: {},
    messages: {},
    
    defaults: {
      restrictions: {
        province: ["QC"],
        country: ["CA"],
      },
      messages: {
        province: {
          en: "Only bars in the province of Quebec are eligible.",
          fr: "Seuls les bars du Québec sont admissibles."
        },
        country: {
          en: "Only bars in Quebec (Canada) are eligible.",
          fr: "Seuls les bars du Québec (Canada) sont admissibles."
        }
      }
    }
  };
  
  Rescousse.Place = Place;
})(window.Rescousse = window.Rescousse || {}, jQuery);
