<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="en">
<head>

<!-- Access the bootstrap Css like this, 
		Spring boot will handle the resource mapping automcatically -->
<link rel="stylesheet" type="text/css"
	href="webjars/bootstrap/3.3.7/css/bootstrap.min.css" />

<!-- 
	<spring:url value="/css/main.css" var="springCss" />
	<link href="${springCss}" rel="stylesheet" />
	 -->
<c:url value="/css/main.css" var="jstlCss" />
<link href="${jstlCss}" rel="stylesheet" />

</head>
<body>
	<div class="container">
		<div class="starter-template">
			<h1>Welcome ${competitor.fullName}</h1>
			<h2>Status: ${status}</h2>
			<h2>Time: ${time}</h2>
			<form:form method="POST" action="/challenge/check" modelAttribute="competitor">
				<form:hidden path="competitorId" />
				<input type="submit" id="submit" value="Check your status" />
			</form:form>
		</div>
	</div>

	<script type="text/javascript"
		src="webjars/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>
