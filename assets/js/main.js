(function($) {
    "use strict";

    // Hide Mobile menu
    function mobileMenuHide() {
        var windowWidth = $(window).width();
        if (windowWidth < 1024) {
            $('#site_header').addClass('mobile-menu-hide');
        }
    }

    $(document).ready(function(){

        // Mobile menu
        $('.menu-toggle').click(function() {
            $('#site_header').toggleClass('mobile-menu-hide');
        });

    });

    // Mobile menu hide
    $(window).on('resize', function() {
         mobileMenuHide();
    });

    // Mobile menu hide on main menu item click
    $('.site-main-menu').on("click", "a", function (e) {
        mobileMenuHide();
    });

})(jQuery);
