/*!
    * Start Bootstrap - Freelancer v6.0.0 (https://startbootstrap.com/themes/freelancer)
    * Copyright 2013-2020 Start Bootstrap
    * Licensed under MIT (https://github.com/BlackrockDigital/startbootstrap-freelancer/blob/master/LICENSE)
    */
    (function($) {
    "use strict"; // Start of use strict
  
    function validatePasswordConf() {
        var messaggio = "Le password non corrispondono";

        // Variabili che contengono i dati inseriti dall'utente nel form di registrazione.
        var password = document.getElementById("pwd1");
        var password_conf = document.getElementById("pwd2");

        // Controlli sui pattern richiesti per tutti i campi.
        if (password.value != password_conf.value) {
            password_conf.setCustomValidity(messaggio);
            return false;
        } else {
            password_conf.setCustomValidity('');
            return true;
        }
    }

    function showResetPwd() {
        $('#loginModal').modal('hide');
        $('#resetmail').val($('#uname').val());
        $('#resetPasswordModal').modal('show');

    }

    $(document).ready(function() {
        $(".toggle-password").click(function() {

            $(this).toggleClass("fa-eye fa-eye-slash");
            var input = $($(this).attr("toggle"));
            if (input.attr("type") == "password") {
                input.attr("type", "text");
            } else {
                input.attr("type", "password");
            }
        });
        // Collapse Navbar
        var navbarCollapse = function() {
            if ($("#mainNav").offset().top > 100) {
                $("#mainNav").addClass("navbar-shrink");
                document.getElementById("dropDownMenu").style.top="62px";
            } else {
                $("#mainNav").removeClass("navbar-shrink");
                document.getElementById("dropDownMenu").style.top="78px";
            }
        };
        // Collapse now if page is not at top
        navbarCollapse();

        // Collapse the navbar when page is scrolled
        $(window).scroll(navbarCollapse);

        // Closes responsive menu when a scroll trigger link is clicked
        $('.js-scroll-trigger').click(function() {
            $('.navbar-collapse').collapse('hide');
        });

        // Smooth scrolling using jQuery easing
        $('a.js-scroll-trigger[href*="#"]:not([href="#"])').click(function() {
            if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') && location.hostname == this.hostname) {
                var target = $(this.hash);
                target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
                if (target.length) {
                    $('html, body').animate({
                        scrollTop: (target.offset().top - 71)
                    }, 1000, "easeInOutExpo");
                    return false;
                }
            }
        });

        // Scroll to top button appear
        $(document).scroll(function() {
            var scrollDistance = $(this).scrollTop();
            if (scrollDistance > 100) {
                $('.scroll-to-top').fadeIn();
            } else {
                $('.scroll-to-top').fadeOut();
            }
        });

        // Activate scrollspy to add active class to navbar items on scroll
        $('body').scrollspy({
            target: '#mainNav',
            offset: 80
        });

        // Floating label headings for the contact form
        $(function() {
            $("body").on("input propertychange", ".floating-label-form-group", function(e) {
                $(this).toggleClass("floating-label-form-group-with-value", !!$(e.target).val());
            }).on("focus", ".floating-label-form-group", function() {
                $(this).addClass("floating-label-form-group-with-focus");
            }).on("blur", ".floating-label-form-group", function() {
                $(this).removeClass("floating-label-form-group-with-focus");
            });
        });
    });
  })(jQuery); // End of use strict
  