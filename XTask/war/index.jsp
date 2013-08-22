<!doctype html>
<!-- The DOCTYPE declaration above will set the -->
<!-- browser's rendering engine into -->
<!-- "Standards Mode". Replacing this declaration -->
<!-- with a "Quirks Mode" doctype may lead to some -->
<!-- differences in layout. -->

<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>

<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">

<!-- -->
<!-- Consider inlining CSS to reduce the number of requested files -->
<!-- -->
<link type="text/css" rel="stylesheet" href="xtask.css">

<!-- -->
<!-- Any title is fine -->
<!-- -->
<title>Web Application Starter Project</title>

<!-- -->
<!-- This script loads your compiled module. -->
<!-- If you add any GWT meta tags, they must -->
<!-- be added before this line. -->
<!-- -->
</head>

<!-- -->
<!-- The body can have arbitrary html, or -->
<!-- you can leave the body empty if you want -->
<!-- to create a completely dynamic UI. -->
<!-- -->
<body>

<%
UserService userService = UserServiceFactory.getUserService();
User user = userService.getCurrentUser();

// Append query string for GWT dev env
String queryString = request.getQueryString();
if (queryString == null) queryString = "";
%>

<!-- OPTIONAL: include this if you want history support -->
<iframe src="javascript:''" id="__gwt_historyFrame" tabIndex='-1' style="position:absolute;width:0;height:0;border:0"></iframe>

<!-- RECOMMENDED if your web app will not function without JavaScript enabled -->
<noscript>
<div style="width: 22em; position: absolute; left: 50%; margin-left: -11em; color: red; background-color: white; border: 1px solid red; padding: 4px; font-family: sans-serif">
Your web browser must have JavaScript enabled
in order for this application to display correctly.
</div>
</noscript>

<div id="userinfo">
You are signing in as <b><%=user == null ? "none" : user.getEmail()%></b><br/>
<a href="<%=userService.createLogoutURL("/index.jsp")%>">Sign in with a different account</a>.
</div>
<div id="gwt"></div>

<script type="text/javascript" language="javascript" src="tasksgwt/tasksgwt.nocache.js"></script>
</body>
</html>