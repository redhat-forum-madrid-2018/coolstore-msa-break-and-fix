<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="en">
<head>
	<title>Red Hat Forum 2018</title>
	<!-- PatternFly Styles -->
	<link rel="stylesheet" href="/node_modules/patternfly/dist/css/patternfly.min.css">
	<link rel="stylesheet" href="/node_modules/patternfly/dist/css/patternfly-additions.min.css">
	
	<!-- JS -->
	<script src="/node_modules/jquery/dist/jquery.min.js"></script>
	<script src="/node_modules/bootstrap/dist/js/bootstrap.min.js"></script>
	
	<!-- C3, D3 - Charting Libraries -->
	<script src="/node_modules/d3/d3.min.js"></script>
	<script src="/node_modules/c3/c3.min.js"></script>
	
	<script src="/node_modules/jquery-match-height/dist/jquery.matchHeight-min.js"></script>
</head>
<body>
<!-- Horizontal Navigation -->
<nav class="navbar navbar-default navbar-pf" role="navigation">
  <div class="navbar-header">
    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse-1">
      <span class="sr-only">Toggle navigation</span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
    </button>
    <a class="navbar-brand" href="/">
      <img src="/img/logo.png" alt="Red Hat" />
    </a>    
  </div>
  <div class="collapse navbar-collapse navbar-collapse-1">
    <ul class="nav navbar-nav navbar-primary">
      <li>
        <a href="/">The Challenge</a>
      </li>
      <li class="active">
        <a href="/challenge/signin">Start the challenge</a>
      </li>
      <li>
        <a href="/dashboard/">Dashboard</a>
      </li>
    </ul>
  </div>
</nav>
<br/>

<div class="panel panel-default">
	<div class="panel-heading">
		<h3 class="panel-title">Sing In to start your challenge</h3>
	</div>
	<div class="panel-body">

		<form:form method="POST" action="/challenge/start" modelAttribute="competitor" cssClass="form-horizontal">
			<div class="form-group">
				<label for="name" class="col-sm-3 control-label">* Name</label>
				<div class="col-sm-9">
					<input type="text" id="fullName" name="fullName" class="form-control">
					<span class="help-block">Enter your name</span>
				</div>
			</div>
			
			<div class="form-group">
				<label for="email" class="col-sm-3 control-label">* Email</label>
				<div class="col-sm-9">
					<input type="email" id="email" name="email" class="form-control">
					<span class="help-block">Enter a valid email address</span>
				</div>
			</div>
		
			<div class="form-group">
				<label for="email" class="col-sm-3 control-label">* Company</label>
				<div class="col-sm-9">
					<input type="text" id="company" name="company" class="form-control">
					<span class="help-block">Enter your company</span>
				</div>
			</div>
			
			<div class="row" style="padding-top: 10px; padding-bottom: 10px;">
				<div class="col-sm-9 col-sm-offset-3">
					<span><input type="submit" class="btn btn-primary" value="Save"/></span>
					<span><input type="reset" class="btn btn-default" value="Cancel"/></span>
				</div>
			</div>
		</form:form>
	</div>
</div>

</body>
</html>
