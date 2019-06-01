/* Header - header.js */

 document.addEventListener('turbolinks:load', function () {
    $('.buffer').hide()
    $('#nav-content').hide();
    $('.dropdown-trigger').dropdown({autoTrigger: false, hover: true, constrainWidth: false, coverTrigger: false, inDuration: 0, outDuration: 0});
    $('.dropdown-trigger-small-menu').dropdown({autoTrigger: false, hover: false, constrainWidth: false, inDuration: 0, outDuration: 0, onOpenStart: toggleNav, onCloseStart: toggleNav, coverTrigger: true});
    $('.sidenav').sidenav();
  });

  function toggleNav() {
    $('.buffer').toggle()
    return false
  }

 document.addEventListener('turbolinks:load', function () {
    $('select').formSelect();
    $('.dropdown-trigger.select-dropdown').dropdown({coverTrigger: true})
  });