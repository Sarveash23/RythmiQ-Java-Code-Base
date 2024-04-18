<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
    Document   : Register
    Created on : Feb 29, 2024, 1:10:45 PM
    Author     : Sarveashwaran
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Register</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                fontFamily: {
                    "cursive": ['cursive', 'sans-serif'],
                }
            }
        }
    </script>
    <style>
        body {
            background-image: url('<%=request.getContextPath()%>/images/bg.jpg');
            background-size: cover;
            backdrop-filter: blur(10px);
            /* Adjust the blur radius as needed */
        }
    </style>
</head>
<body>
<div class="h-screen flex pt-0 md:pt-2 justify-center items-center bg-cover no-repeat">
<form:form method="POST" modelAttribute="userForm"  action="/registration"
          class="p-6 w-[320px] md:w-[575px] bg-white shadow-xl rounded-[10px] h-[500px] flex flex-col items-center justify-center space-y-6">
        <h1 class="text-center text-4xl">Registration
        </h1>
        <div class="flex flex-col justify-center items-start space-y-1 md:space-y-6">
            <div
                    class="flex flex-col md:flex-row justify-center md:justify-between items-start md:items-center space-y-4 md:space-y-0 space-x-0 md:space-x-4 w-[300px] md:w-[500px]">
                <label for="username" class="text-sm md:text-xl">Username</label>
                <input
                        class="placeholder:italic placeholder:text-slate-400 block bg-white w-[300px] md:w-[400px] border border-slate-300 rounded-md p-2 shadow-sm focus:outline-none focus:border-sky-500 focus:ring-sky-500 focus:ring-1"
                        placeholder="Type your Username..." type="text" name="username" id="username" required="required" />
               <br> <form:errors path="username"></form:errors>
            </div>
            <div
                    class="flex flex-col md:flex-row justify-center md:justify-between items-start md:items-center space-y-4 md:space-y-0 space-x-0 md:space-x-4 w-[300px] md:w-[500px]">
                <label for="password" class="text-sm md:text-xl">Password</label>
                <input
                        class="placeholder:italic placeholder:text-slate-400 block bg-white w-[300px] md:w-[400px] border border-slate-300 rounded-md p-2 shadow-sm focus:outline-none focus:border-sky-500 focus:ring-sky-500 focus:ring-1"
                        placeholder="Type your Password..." type="password" name="password" id="password" required="required"/>
            </div>
            <div
                    class="flex flex-col md:flex-row justify-center md:justify-between items-start md:items-center space-y-4 md:space-y-0 space-x-0 md:space-x-4 w-[300px] md:w-[500px]">
                <label  class="text-sm md:text-xl">Gender</label>
                <div class="bg-white w-[300px] md:w-[400px]">
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="gender" id="flexRadioDefault1" value="Male" checked>
                        <label class="form-check-label" for="flexRadioDefault1">
                            Male
                        </label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="gender" id="flexRadioDefault2" value="Female" >
                        <label class="form-check-label" for="flexRadioDefault2">
                            Female
                        </label>
                    </div>
                </div>
            </div>
            <div
                    class="flex flex-col md:flex-row justify-center md:justify-between items-start md:items-center space-y-4 md:space-y-0 space-x-0 md:space-x-4 w-[300px] md:w-[500px]">
                <label  class="text-sm md:text-xl">School</label>
                <input
                        class="letterNumberInput placeholder:italic placeholder:text-slate-400 block bg-white w-[300px] md:w-[400px] border border-slate-300 rounded-md p-2 shadow-sm focus:outline-none focus:border-sky-500 focus:ring-sky-500 focus:ring-1"
                        placeholder="Type your School..." type="text" name="school" required="required" />
            </div>
        </div>
        <button type="submit" class="bg-[#0059D6] text-white w-20 h-10 rounded-[5px]">
            Register
        </button>
    </form:form>
</div>

<script>

    document.getElementById('password').addEventListener('input', function(event) {
        const inputValue = event.target.value;
        if (/^[0-9,]*$/.test(inputValue)) {
            event.target.value = inputValue;
        } else {
            event.target.value = inputValue.slice(0, -1);
        }
    });
</script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/js/custom.js"></script>
</body>
</html>



<%--
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Create an account</title>

    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/common.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>

<div class="container">

    <form:form method="POST" modelAttribute="userForm" class="form-signin">
        <h2 class="form-signin-heading">Create your account</h2>
        <spring:bind path="username">
            <div class="form-group ${status.error ? 'has-error' : ''}">
                <form:input type="text" path="username" class="form-control" placeholder="Username"
                            autofocus="true"></form:input>
                <form:errors path="username"></form:errors>
            </div>
        </spring:bind>

        <spring:bind path="password">
            <div class="form-group ${status.error ? 'has-error' : ''}">
                <form:input type="password" path="password" class="form-control" placeholder="Password"></form:input>
                <form:errors path="password"></form:errors>
            </div>
        </spring:bind>

        <spring:bind path="passwordConfirm">
            <div class="form-group ${status.error ? 'has-error' : ''}">
                <form:input type="password" path="passwordConfirm" class="form-control"
                            placeholder="Confirm your password"></form:input>
                <form:errors path="passwordConfirm"></form:errors>
            </div>
        </spring:bind>

        <button class="btn btn-lg btn-primary btn-block" type="submit">Submit</button>
    </form:form>

</div>
<!-- /container -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>
--%>
