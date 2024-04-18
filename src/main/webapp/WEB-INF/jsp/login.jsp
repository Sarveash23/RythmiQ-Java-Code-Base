<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
    Document   : Login
    Created on : Mar 19, 2024, 12:59:43 PM
    Author     : Sarveashwaran
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login</title>
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
    <form method="POST" modelAttribute="login"  action="/login"
               class="p-6 w-[492px] bg-white shadow-xl rounded-[10px] h-[600px] flex flex-col items-center justify-center space-y-6">
        <img src="<%=request.getContextPath()%>/images/logo.jpg" class="w-[200px] h-[100px]" alt="" srcset="" />
        <h1 class="text-center text-2xl md:text-4xl">Welcome To RhythmiQ <br> <span class="font-cursive italic">Learn
          Music Your Own
          Way</span>
        </h1>
        <div class="flex flex-col justify-center items-center space-y-6">
            <div class="flex flex-col justify-start">
                <label for="username" class="text-xl">Username</label>
                <input
                        class="placeholder:italic placeholder:text-slate-400 block bg-white w-[400px] border border-slate-300 rounded-md p-2 shadow-sm focus:outline-none focus:border-sky-500 focus:ring-sky-500 focus:ring-1"
                        placeholder="Type your Username..." type="text" name="username" id="username" required="required" value="${login.username}" />
                <span style="color: red; "><c:out value="${errorUsername}"></c:out></span>
            </div>
            <div class="flex flex-col justify-start">
                <label for="password" class="text-xl">Password</label>
                <input
                        class="placeholder:italic placeholder:text-slate-400 block bg-white w-[400px] border border-slate-300 rounded-md p-2 shadow-sm focus:outline-none focus:border-sky-500 focus:ring-sky-500 focus:ring-1"
                        placeholder="Type your Password..." type="password" name="password" id="password" required="required" />
                <span style="color: red; "><c:out value="${errorPassword}"></c:out></span>
            </div>
        </div>
        <button type="submit" class="bg-[#0059D6] text-white w-full md:w-16 h-10 rounded-[5px]" >
            Login
        </button>
        <h1>Don't Have an Account ? <a class="text-[#0059D6] underline" href="<%=request.getContextPath()%>/registration">Click Here</a></h1>
    </form>
</div>
</body>
</html>