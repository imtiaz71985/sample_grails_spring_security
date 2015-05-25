<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="cache-control" content="public"/>
    <title><g:message code="springSecurity.login.title"/></title>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap/css/bootstrap.min.css')}"/>
    <script type="text/javascript"
            src="${resource(dir: 'js', file: 'jquery/jquery-1.11.2.min.js')}"></script>
    <script type="text/javascript"
            src="${resource(dir: 'js', file: 'bootstrap/bootstrap.min.js')}"></script>
</head>

<body class="container-fluid" style="padding-top: 10%; padding-left: 35%; background-color: #F8F8F8;">
<div class="row">
    <div class="col-md-6">
        <div class="panel panel-default">
            <div class="panel-heading">
                <div class="panel-title">
                    <div class="row">
                        <div class="col-md-7" style="font-weight: bold">Sign In</div>
                    </div>
                </div>
            </div>

            <div class="panel-body">
                <form action='${postUrl}' autocomplete='on'
                      method="post" class="form-horizontal form-widgets" role="form" id='loginForm'>

                    <div class="form-group">
                        <label class="col-md-3 control-label" for="username">Login ID:</label>

                        <div class="col-md-9">
                            <input type="text" class="form-control" id="username" name="j_username" tabindex="1"
                                   placeholder="Login Id" value="admin"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-md-3 control-label" for="password">Password:</label>

                        <div class="col-md-9">

                            <input type="password" class="form-control" id="password" name="j_password"
                                   tabindex="2"
                                   placeholder="Password" value="secret"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-md-3">&nbsp;</div>

                        <div class="col-md-5">
                            <button id="create" name="create" type="submit" class="btn btn-default" tabindex="5">
                                <span class="glyphicon glyphicon-play"></span> Login
                            </button>
                        </div>
                    </div>
                </form>
                <div>
                    <g:if test="${flash.message && !flash.success}">
                        <div class='alert alert-danger col-md-12' id="login_msg_"
                             style="margin-bottom: 0">${flash.message}</div>
                    </g:if>
                    <g:if test="${flash.message && flash.success}">
                        <div class='alert alert-success col-md-12' id="login_msg_"
                             style="margin-bottom: 0">${flash.message}</div>
                    </g:if>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
