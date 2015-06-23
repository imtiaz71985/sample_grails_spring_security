<script type="text/javascript">
    var router = false;
    $(document).ready(function() {
        initRouter();
    });

    function initRouter() {
        router = new kendo.Router();
        router.route("/:controller/:action", function (controller, action, params) {
        });
        router.bind("change", function (e) {
            var url = e.url;
            if ((url == "/") || (url == "")) {
                return false;
            }else if(url.substr(0,12)=='introduction'){
                loadInDashBoard(url);
            }else{
                load(url);
            }
        });
        router.start();
    }

    function loadInDashBoard(loc) {
        jQuery.ajax({
            type: 'post',
            url: loc,
            success: function (data, textStatus) {
                $('#dash-container').html(data);
            },
            complete: function (XMLHttpRequest, textStatus) {

            }
        });
    }

    function load(loc) {
        jQuery.ajax({
            type: 'post',
            url: loc,
            success: function (data, textStatus) {
                markLeftMenu(loc);
                $('#page-wrapper').html(data);
            },
            complete: function (XMLHttpRequest, textStatus) {

            }
        });
    }
    function markLeftMenu(loc){
        $("#navbar a").removeClass('active');
        $("#navbar a[href='" + '#'+loc + "']").addClass('active').focus();

    }

    function redirectToLogoutPage() {
        window.location = "<g:createLink controller="logout"/>";
    }
</script>