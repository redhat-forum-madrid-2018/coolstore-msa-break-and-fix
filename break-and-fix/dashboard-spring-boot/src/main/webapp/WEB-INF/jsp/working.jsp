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
		<h3 class="panel-title">Your challenge started!! Good Luck!!</h3>
	</div>
	<div class="panel-body">
			<h1>Welcome ${competitor.fullName}</h1>
			<h2>Status: ${status}</h2>
			<h2>Time: ${time}</h2>
			<form:form method="POST" action="/challenge/check" modelAttribute="competitor">
				<form:hidden path="competitorId" />
				<input type="submit" id="submit" class="btn btn-default btn-lg" value="Check your status" />
			</form:form>
	</div>
</div>
</body>
</html>
