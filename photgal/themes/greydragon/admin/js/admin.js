$().ready(function() {
  $("div.infos").delay(8000).slideUp('slow', function() { $('div.infos').hide(); });
  $("#menubar dl dd:visible").parent('dl').find('dt').addClass('menu-header-active');
  $("form li label input[type=checkbox]").change(function() { $(this).prev().toggleClass('fa-square').toggleClass('fa-check-square'); });
  $("#menubar dl").click(function() {
    $("#menubar dl").removeClass('menu-focused');
    $(this).addClass('menu-focused');
  });
  $(".ajax").colorbox({ scrolling: true, maxWidth: '90%', maxHeight: '90%' });

  var page = $(location).attr('href');
  var pathName = page.substring(page.lastIndexOf('/') + 1, page.length);
  if (pathName) {
    $('#pwgMain #menubar dl ul.scroll li a').each(function(){
      var href = $(this).attr('href');
      if (pathName.indexOf(href) == 0) {
        $(this).addClass('active-on');
      } else {
        $(this).removeClass('active-on');
      }
    });
  }
});
