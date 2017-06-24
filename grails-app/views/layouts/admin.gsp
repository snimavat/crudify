<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title><g:layoutTitle/></title>

    <asset:link rel="shortcut icon" href="lapsi/favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

    <asset:stylesheet href="crudify/admin.css"/>
    <asset:javascript src="crudify/admin.js" />

    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.4/css/bootstrap-datepicker.min.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.4/js/bootstrap-datepicker.js"></script>
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">

    <g:layoutHead/>
</head>
<body data-context="${request.contextPath}">
<nav class="navbar navbar-default navbar-static-top">
    <div class="container">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle navbar-toggle-sidebar collapsed">MENU</button>
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <g:link controller="home" namespace="admin" class="navbar-brand">Admin</g:link>

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


<script src="https://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.8.3/underscore-min.js"></script>
<script>
    _.templateSettings = {
        interpolate: /\{\{(.+?)\}\}/g
    };
</script>
</body>
</html>
