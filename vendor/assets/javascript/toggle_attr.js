$.fn.toggleAttr = function(a, b) {
  var c = (b === undefined);
  return this.each(function() {
    if((c && !$(this).is("["+a+"]")) || (!c && b)) $(this).attr(a,a);
    else $(this).removeAttr(a);
  });
};