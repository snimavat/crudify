<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title><g:layoutTitle/></title>

    <asset:link rel="shortcut icon" href="lapsi/favicon.ico" type="image/x-icon"/>

    <asset:stylesheet href="crudify/admin.css"/>
    <asset:javascript src="crudify/admin.js" />
    <asset:stylesheet src="font-awsome/css/font-awesome.min.css"/>


    <g:layoutHead/>
</head>
<body data-context="${request.contextPath}">
<nav class="navbar navbar-default navbar-static-top">
    <div class="container">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle navbar-toggle collapsed">MENU</button>
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>

        <g:link controller="home" namespace="admin" class="navbar-brand">Admin</g:link>
        </div>

        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right">
                <li>
                    <a href="/logoff">Logout</a>
                </li>
            </ul>
        </div>
    </div>
    </div><!-- /.container-fluid -->
</nav>
<div class="container main-content">
    <div class="row">

        <div class="col-sm-2">
            <g:render template="/admin/templates/sideMenu" />
        </div>

        <div class="col-sm-10">
            <g:layoutBody/>
        </div>

    </div>
</div>


<asset:javascript src="underscore/underscore-min.js"/>
<script>
    _.templateSettings = {
        interpolate: /\{\{(.+?)\}\}/g
    };
</script>
</body>
</html>
