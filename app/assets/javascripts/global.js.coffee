$(document).ready ->
  $('div.pageBar')
    .on 'click', 'div.pageBar_dropdown_btn', ->
      togglePageBarDropdown($(this))
    .on 'mouseenter', 'div.pageBar_dropdown_btn', ->
      togglePageBarDropdown($(this), true)
    .on 'mouseleave', 'div.pageBar_dropdown_btn', ->
      togglePageBarDropdown($(this), false)

togglePageBarDropdown = (btn, show) ->
  dropdownContent = $('div.pageBar_dropdown_content', btn)
  if typeof show != 'undefined'
    if btn.attr('data-show') == 'true'
      return;
    dropdownContent.toggle(show)
  else
    show = btn.attr('data-show') != 'true';
    btn.attr('data-show', show)
    dropdownContent.toggle(show)