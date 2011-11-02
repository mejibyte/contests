$(function(){
  if ($("#scoreboard").size() > 0) {
    setInterval('$.getScript($("#scoreboard").attr("data-url"));', 1000 * 60); // Periodically poll for changes
  }
});