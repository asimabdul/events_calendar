$(document).ready(ready);
$(document).on("page:load", ready);


function ready() {
  setupEvents();
}

function setupEvents() {
  $(".calendar-view").on("click", ".panel-close-btn", function(e) {
    $(this).closest("div.panel").hide();
  })

  $(".event_link").on("click", function(e) {
    $("div.panel").remove();
    var domObject = $(e.target);
    var panel = constructPanel(domObject.text(), domObject.data("invited"));
    $(".calendar-view").append(panel);
  })

  $(".more_events_link").on("click", function(e) {
    $("div.panel").remove();
    constructMultiplePanels($(e.target));
  })  

}


function constructPanel(eventName, eventInvites) {
  var panel = '<div class="panel panel-info"><div class="panel-heading"><span class="event-title">';
  panel += eventName;
  panel += '</span><span class="pull-right"><a class="panel-close-btn" href="#"><i class="glyphicon glyphicon-remove"></i></a></span></div><div class="panel-body">';
  panel += 'Guests invited: <strong>' + eventInvites;
  panel += '</strong></div></div>';
  return panel;
}

function constructMultiplePanels(element) {
  var eventNames = element.data("event-names").split(",");
  var eventInvites = element.data("event-invites").split(",");
  var panels = [];
  
  $.each(eventNames, function(i,e) {
    panels.push(constructPanel(e, eventInvites[i]));
  })
  
  $.each(panels, function(i, panel) {
    $(".calendar-view").append(panel);
  })
}