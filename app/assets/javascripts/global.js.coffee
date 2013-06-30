$(document).ready ->
  $('div.pageBar')
    .on 'click', 'div.pageBar_dropdown_btn', (e) ->
      togglePageBarDropdown(e, $(this))
    .on 'mouseenter', 'div.pageBar_dropdown_btn', (e) ->
      togglePageBarDropdown(e, $(this), true)
    .on 'mouseleave', 'div.pageBar_dropdown_btn', (e) ->
      togglePageBarDropdown(e, $(this), false)

togglePageBarDropdown = (e, btn, show) ->
  dropdownContent = $('div.pageBar_dropdown_content', btn)
  if typeof show != 'undefined'
    if btn.attr('data-show') == 'true'
      return
    dropdownContent.toggle(show)
  else
    if $(e.target).closest('div.pageBar_dropdown_content').length
      return
    show = btn.attr('data-show') != 'true';
    btn.attr('data-show', show)
    dropdownContent.toggle(show)