(function() {

  function setCurrentTab() {
    $(".image-metadata-tab").hide();
    var cur_tab = window.location.hash;
    if (cur_tab) {} else { cur_tab = "#" + $(".image-metadata li.active").attr("rel"); }
    if (cur_tab !== "#undefined") {
      if ((cur_tab == '#comments') || (cur_tab == '#edit_comment')) { cur_tab = "#tab-comment"; }
      var cur_tab_rel = cur_tab.replace("#", "");
      $("ul.image-metadata li").removeClass("active");
      $("ul.image-metadata li[rel='" + cur_tab_rel + "']").addClass("active");
      if (cur_tab == "#tab-comment") { normalizeComments("tab-comment"); }
      $(cur_tab).show();
    } else {
      $(".image-metadata-tab").first().show(); 
    }
  }

  function normalizeComments(activeTab) {
    if (activeTab == 'tab-comment') {
      $("li.commentElement .actions a").each(function( index ) {
        if ($(this).is('a[href*="#"]')) { 
        } else {
          var href = $(this).attr("href") + "#tab-comment";
          $(this).attr("href", href);
        }
      });
    }
  }

  function switchTab(tab) {
    if ($(tab).is("#image-metadata-toggle")) {
      $(".image-metadata-tabs").slideToggle("fast");      
      if ($("#image-metadata-toggle").is(".glyphicon-chevron-down")) {
        $("#image-metadata-toggle").removeClass("glyphicon-chevron-down").addClass("glyphicon-chevron-up");
      }else{
        $("#image-metadata-toggle").removeClass("glyphicon-chevron-up").addClass("glyphicon-chevron-down");
      }
      return;
    }
    $("ul.image-metadata li").removeClass("active");
    $(tab).addClass("active");
    $(".image-metadata-tab").hide();
    var activeTab = $(tab).attr("rel"); 
    window.location.hash = '#' + activeTab;
    if (p_pict_tab_anim == "on") {
      $("#" + activeTab).fadeIn();
    }else{
      $("#" + activeTab).show();
    }
    normalizeComments(activeTab);
    $("#image-metadata-toggle").removeClass("glyphicon-chevron-down").addClass("glyphicon-chevron-up");
    $(".image-metadata-tabs").show("fast");
  }

  jQuery(function(){
    if ($('#TagsTable #Tags').css('background-image') == "none") {
      $('#TagsTable #Tags .tags-edit-marker').hide();
    }else{
      $('#TagsTable #Tags .tags-edit-marker').show();
      $('#TagsTable #Tags').css("background", "none");
    }

    if ($('#image-metadata-ico').length) {
      $("#image-metadata-ico>ul>li").each(function() {
        var el = $(this);
        var classNames = el.attr('class').split(" ");
        if (classNames.length > 0) {
          var classMeta = classNames[0].split("-");
          if ((classMeta.length == 2) && (classMeta[0] == "meta")) { 
            var metaTag = classMeta[1];
            if (metaTag == "info")    { var _href = "div#tab-meta"; } else { var _href = "div#tab-" + metaTag; }
            if (metaTag == "comment") { var _width = "1200px"; } else if (metaTag == "cart") { _width = "600px"; } else { var _width = false; }
            
            el.colorbox({ inline:true, href: _href, className:"image-metadata-overlay", speed:200, opacity:0.6, width: _width });
          }
        }
      });
    }else{
      setCurrentTab();
      $("ul.image-metadata li").click(function() { switchTab(this); });
    }
  });
}());