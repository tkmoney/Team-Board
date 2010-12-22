var application = function($){
  var app = this;
  this.tracker = {};
  this.tracker.activity = {}

  function init(){
    fetchActivityFeed(function(){
      activity_html = new EJS({url: '/javascripts/activity.ejs'}).render({data: app.tracker.activity});
      console.log(activity_html);
      $(".activity ul").empty().append(activity_html);
    });
  };


  function fetchActivityFeed(callback){
    $(app).trigger('fetching_activity');
    $.get('/tracker/index', function(data){
      app.tracker.activity = $.parseJSON(data);
      callback();
    });
  };


  $(document).ready(function(){
    init();
  });
}(jQuery);