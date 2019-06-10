$(document).on('turbolinks:before-cache', function() {     // this approach corrects the select 2 to be duplicated when clicking the back button.
        $('.select-wrapper').select2('destroy');
        $('.select-search-select2').select2('destroy');
    } );