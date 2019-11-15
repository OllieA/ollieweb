  <fieldset>
  <legend>{'Help'|@translate}</legend>
  <ul>
    <li><h3>{'Prerequisites'|@translate}</h3>
      <p><b>{'REQUIREMENTS NEED TO BE MET FOR THE THEME TO FUNCTION PROPERLY.'|@translate}</b><br>
        {'Please refer to information on the left.'|@translate}
      </p></li>

    <li><h3>{'Suggested Modules'|@translate}</h3>
      <p>{'Optional plugins found to be usefull in everyday usage.'|@translate}</p>
    </li>

    <li><h3>{'General Settings'|@translate}</h3>
      <p><b>{'Logo Image'|@translate}</b> - {'optional'|@translate} - {'Path to image used as gallery logo. Recommended logo height is 80px. If you need bigger space for your logo, CSS adjustments would have to be made'|@translate}<br>
      <b>{'Header Text'|@translate}</b> - {'optional'|@translate} - {'Text to be added in header area next to Logo'|@translate}<br>
      {'Supported macros'|@translate}:
        <ul><li>%gallery_title% - {'Gallery title'|@translate}</li>
        </ul>
      <p>{'If neither Logo Image or Header Text are set, header region would collapse'|@translate}<br>
      <b>{'Footer Text'|@translate}</b> {'allows adding content in the footer below menu links and Site\'s credits.'|@translate}</p>
      <p><b>{'Color Pack'|@translate}</b> - {'Select color pack to be used with the theme. It allows changing colors, styles, theme for the pages. By default theme includes 4 color packs: blackhawk, greydragon, slateblue, and whitehawk, but you could extend the list by creating copy of one of the existing colorpack folders and adjusting managed styles.'|@translate}</p>
    </li>

    <li><h3>{'Advanced Options - Custom CSS'|@translate}</h3>
      <p>{'This option allows fine tune Theme\'s styles to better suit your personal taste.'|@translate}</p>
      <p>{'Few examples:'|@translate}</p>
      <ul>
        <li>{'Remove fixed width'|@translate}:<br>&nbsp;&nbsp;&nbsp;body { width: auto; }</li>
        <li>{'Remove fixed width but keep min-width'|@translate}:<br>&nbsp;&nbsp;&nbsp;body { width: auto; min-width: 1270px; }</li>
        <li>{'Add Thumb shadow for gdThumb: Set margin between thumbs to 10-14px. Modify shadow color to match your theme'|@translate}:<br>&nbsp;&nbsp;&nbsp;.gdthumb { box-shadow: 6px 6px 3px #888888; }</li>
        <li>{'Remove Root link in page\'s breadcrumbs: set $conf[\'level_separator\'] = \'\'; and apply CSS'|@translate}:<br>&nbsp;&nbsp;&nbsp;.browsePath a:first-child { display: none; }<br>&nbsp;&nbsp;&nbsp;.browsePath a:after { content: " :: "; }</li>
        <li>{'Change height of the footer to accomodate larger content of'|@translate} <b>{'Footer Text'|@translate}</b>:<br>&nbsp;&nbsp;&nbsp;#g-footer { min-height: 5em !important; }</li>
        <li>{'Center'|@translate} <b>{'Footer Text'|@translate}</b>:<br>&nbsp;&nbsp;&nbsp;.g-footer-bottomleft { text-align: center; }</li>
      </ul></li>

    <li><h3>{'Favicon Tips'|@translate}</h3>
      <p>{'For URLs please use absolute or relative path including filename'|@translate}</p>
      <p>{'Additional Information'|@translate}</p>
      <table>
        <tr><th>{'Favicon Wiki'|@translate}</th><td><a href="http://en.wikipedia.org/wiki/Favicon" target="_blank">{'Wikipedia'|@translate}</a> - {'read more about Favicon types and sizes'|@translate}</td></tr>
        <tr><th>{'Favicon Generator'|@translate}</th><td><a href="http://www.html-kit.com/favicon/" target="_blank">{'HTML Kit'|@translate}</a> - {'Favicon Generator'|@translate}</td></tr>
        <tr><th>{'Favicon CC editor'|@translate}</th><td><a href="http://www.favicon.cc/" target="_blank">{'Favicon CC'|@translate}</a> - {'Simple Favicon editor'|@translate}</td></tr>
        <tr><th>{'Favicon validator'|@translate}</th><td><a href="http://www.html-kit.com/favicon/validator" target="_blank">{'HTML Kit'|@translate}</a> - {'Validate Favicon for browser compatiblity'|@translate}</td></tr>
        <tr><th>{'Apple Touch Icon HowTo'|@translate}</th><td><a href="http://developer.apple.com/library/safari/#documentation/appleapplications/reference/safariwebcontent/ConfiguringWebApplications/ConfiguringWebApplications.html" target="_blank">{'Apple'|@translate}</a> - {'How-to on how to create a PNG to use as an Apple Touch Icon'|@translate}</td></tr>
      </table>
    </li>
  </ul>
  </fieldset>