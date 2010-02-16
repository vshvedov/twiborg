$(function(){
  var project_id = $('#project_id').val();
  swfobject.embedSWF("/open-flash-chart.swf", "ivents-graph", "100%", "400", "9.0.0", "/expressInstall.swf",{"data-file":'/projects/'+project_id+'/ivents_graph', id:'ivents-graph'}, {data_url:'/projects/'+project_id+'/ivents_graph'});
  $('.chart-controls a').click(function(){
    var block = $(this).parent().parent();
    if(!block.hasClass('disabled')){
      action = $(this).attr('rel');
      if(action == '+') block.find('.offset').val((block.find('.offset').val()*1) - 1);
      else if(action == '-') block.find('.offset').val((block.find('.offset').val()*1) + 1);
      else{
        block.find('.unit').val(action);
        block.find('.offset').val(0);
      }
      var chart_id = block.attr('rel');
      var url = $('#'+chart_id).find('param[name="data_url"]').attr('value') + '?unit=' + block.find('.unit').val() + '&offset=' + block.find('.offset').val();
      document.getElementById(chart_id).reload(url)
      block.addClass('disabled');
    }
    return false
  })
  ofc_resize = function(data){
    $('.chart-controls[rel="' + data[4] + '"]').removeClass('disabled');
  }
})
