$(document).ready ->
  $('div#page-banner').click -> window.location = '/'
  
  $('div.gallery-image').each ->
    $this = $(this)
    $this.colorbox({
      rel: 'group1',
      title: $this.attr('data-text'),
      onComplete: cboxComplete
    })
    
cboxComplete = () ->
  title = $('div#cboxTitle')
  titleHeight = title.height()
  title.css('top', -titleHeight + 'px')
  title.closest('div#cboxWrapper').css('padding-top', titleHeight + 'px')