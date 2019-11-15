(function() {

  var menubar=jQuery("#menubar"),
      menuswitcher = null,
      content=jQuery("#the_page > .content"),
      pcontent=jQuery("#content");

  // static, opened, closed, disabled, force_hide

  function hideMenu(delay) {
    if ((p_animated_menu == "on")  && (delay != 0)) {
      jQuery("#menubar").fadeOut("fast");
    } else {
      jQuery("#menubar").hide();
    }

    menuswitcher.addClass("menuhidden").removeClass("menushown");
    content.addClass("menuhidden").removeClass("menushown");
    pcontent.addClass("menuhidden").removeClass("menushown");

    jQuery.cookie('side-menu', 'hidden', {path: "/"});
  }

  function showMenu(delay) {
    if ((p_animated_menu == "on") && (delay != 0)) {
      jQuery("#menubar").fadeIn("fast");
    } else {
      jQuery("#menubar").show();
    }

    menuswitcher.addClass("menushown").removeClass("menuhidden");
    content.addClass("menushown").removeClass("menuhidden");
    pcontent.addClass("menushown").removeClass("menuhidden");

    jQuery.cookie('side-menu', 'visible', {path: "/"});
  }

  jQuery(function(){

    if (p_hideabout) { jQuery('a[href$="about.php"]').parent().remove(); }

    if (p_main_menu == "force_hide") {
      $("#menubar").on('mouseleave', function(e) {
        $(this).hide();
      });
    }

    if (p_main_menu == 'static') { 
      var mh = jQuery('#menubar').height();
      jQuery('.contentWithMenu').css("min-height", mh + 30);
      jQuery('#menubar').css("display", "block"); 
      return; 
    } else if (p_main_menu == 'header-bottom' || p_main_menu == 'header-right') {
    } else if (p_main_menu !== 'disabled') {
      jQuery('<span id="menuSwitcher">&nbsp;</span>').insertBefore('div.titrePage h2 a:first');
      menuswitcher = jQuery("#menuSwitcher");
    }

    if (menubar.length == 1 && p_main_menu != "disabled" && p_main_menu != 'header-bottom' && p_main_menu != 'header-right') {
      if (p_main_menu == "force_hide") {
        jQuery.cookie('side-menu', 'hidden', {path: "/"});
      }else{
        if (jQuery.cookie('side-menu') == undefined) {
          if (p_main_menu == 'opened') {
            jQuery.cookie('side-menu', 'visible', {path: "/"});
          }else{
            jQuery.cookie('side-menu', 'hidden', {path: "/"});
          }
        }
      }

      if (jQuery.cookie('side-menu') == 'visible') {
        showMenu(0);
      } else {
        hideMenu(0);
      }

      menuswitcher.click(function(e){
        if (menubar.is(":hidden")) {
          showMenu(1);
        } else {
          hideMenu(1);
        }
        e.preventDefault();
      });
    }
    else if (menubar.length == 1 && p_main_menu=="disabled") {
      hideMenu(0);
      menuswitcher.hide();
    }

  });
}());