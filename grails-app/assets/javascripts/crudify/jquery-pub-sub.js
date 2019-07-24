(function($) {

    var o = $({});

    $.one = function() {
        o.one.apply(o, arguments);
    };

    $.subscribe = function() {
        o.on.apply(o, arguments);
    };

    $.unsubscribe = function() {
        o.off.apply(o, arguments);
    };

    $.publish = function() {
        o.trigger.apply(o, arguments);
    };

}(jQuery));

//based on https://gist.github.com/cowboy/661855