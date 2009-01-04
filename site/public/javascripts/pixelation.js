function updatePixelationStyles(transport) {
  setInnerText($('pixelation-styles'), transport.responseText);
  clearCompilationError();
}

function clearCompilationError() {
  $('error').removeClassName("active");
  setInnerText($('error'), "");      
}
function displayCompilationError(transport) {
  setInnerText($('error'), transport.responseText);  
  $('error').addClassName("active");
}

function setInnerText(element, value) {
  if (element['innerText']) {
    element.innerText = value;
  } else {
    element.textContent = value;
  }    
}

function render_pixels() {
  render_line.defer($('pixels'), 0, 100)
}

var x_matcher = /x-(\d\d?)/;
var y_matcher = /y-(\d\d?)/;
function mouse_over_pixel(event) {
  if (!hover_enabled) return;
  var info = $('pixel-info');
  info.show();
  var element = event.element();
  var information = element.inspect();
  setInnerText($('pixel-tag'), information);
  var x = -1;
  var y = -1;
  var cns = element.classNames();
  cns.each(function(cls){
    if (cls.match(x_matcher)) {
      x = parseInt(RegExp.$1);
    } else if (cls.match(y_matcher)) {
      y = parseInt(RegExp.$1);
    }
  })
  if ((x > 0) && (y > 0)) {
    zoomTo(x,y);
  }
}

function zoomTo(x,y) {
  for (var i = 0; i < 9; i++) {
    for (var j = 0; j < 9; j++) {
      $('z-'+i+'-'+j).className = "x-"+(x+j-4)+" y-"+(y+i-4)
    }
  }
}

function hide_pixel_info(event) {
  if (!hover_enabled) return;
  $('pixel-info').hide();
}

var hover_enabled = true;
function select_pixel(event) {
  hover_enabled = false;
  $('deselect-control').show();
  $('select-message').hide();
}

function deselect_pixel() {
  $('deselect-control').hide();
  $('select-message').show();
  hover_enabled = true;  
  hide_pixel_info();
}

function attach_interactive_behaviors() {
  $$('.pixelated').each(function(e){
    e.observe('mouseover', mouse_over_pixel)
    e.observe('mouseout', hide_pixel_info)
    e.observe('click', select_pixel)
  });
  new Form.Element.Observer('stylesheet', 1, function(element, value) {
    new Ajax.Request(compilation_path, {
      parameters : 'sass='+escape(value),
      onSuccess : updatePixelationStyles,
      on400 : displayCompilationError
    })
  });
}
function render_line(container, line_number, last_line_number) {
  var line_element = document.createElement("div");
  html = "";
  for (var x = 0; x < 100; x++) {
    html += '<p class="x-' + x + ' y-' + line_number + '" />'
  }
  line_element.innerHTML = html;
  container.insert(line_element, {position : 'bottom'})
  if (line_number + 1 < last_line_number) {
    render_line.defer(container, line_number + 1, last_line_number)
  } else if (last_line_number == 100) {
    $('please-wait').hide();
    $$('.pixelated').each(function(e){
      e.show();
    });
    attach_interactive_behaviors.defer();
  }
}
window.onload = render_pixels;