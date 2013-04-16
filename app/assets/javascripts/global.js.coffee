$(document).ready ->
  $('div#page-banner').click -> window.location = '/'
  
  $('div.gallery-image').each ->
    $this = $(this)
    $this.colorbox({ rel: 'group1', title: $this.attr('data-text') })