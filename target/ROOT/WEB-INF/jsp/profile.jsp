<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>JSP Page</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
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
            background-image: url('./img/bg.jpg');
            background-size: cover;
            backdrop-filter: blur(10px);
            /* Adjust the blur radius as needed */
        }
        .table-borderless > tbody > tr > td,
        .table-borderless > tbody > tr > th,
        .table-borderless > tfoot > tr > td,
        .table-borderless > tfoot > tr > th,
        .table-borderless > thead > tr > td,
        .table-borderless > thead > tr > th {
            border: none;
        }
    </style>
</head>
<body>
<div class="w-full  justify-center">
    <div class="bg-gray-300 drop-shadow-lg w-full h-20 flex flex-row justify-between p-2">
        <img src="/images/logo2.jpg" class="w-[174px] h-[72px]" alt="" srcset="">
        <img id="profileLink" onclick="redirectToNewPage()" src="/images/profile.jpg" class="w-[72px] h-[72px]" alt="" srcset="">
    </div>
    <br />
    <br />
    <form:form method="POST" modelAttribute="userForm"  action="/profile">
        <input type="hidden" name="id" value="${userForm.id}" />

        <div class="container">
           <div class="row">
               <div class="col-md-3"></div>
               <div class="col-md-6">
                   <div class="card">
                       <div class="card-header">
                           <div class="row">
                               <div class="col-md-6">
                                   <c:if test="${edit}">Update Profile</c:if>
                                   <c:if test="${!edit}"> Profile Information</c:if>
                               </div>
                               <div class="col-md-6 pull-right">
                                   <c:if test="${edit}">  <button type="submit" class="btn btn-primary">Save</button></c:if>
                                   <c:if test="${!edit}">  <span> <a style=" padding: 4px;" class="btn btn-primary" href="<%=request.getContextPath()%>/edit-profile">Edit Profile</a></span></c:if>

                                   <span> <a style="margin-left: 20px; padding: 4px;" class="btn btn-success" href="<%=request.getContextPath()%>/main">Back</a></span>
                               </div>
                           </div>
                       </div>
                       <div class="card-body">
                           <table class="table ">

                               <thead>
                               <tr>
                                   <td>Username</td>
                                   <td><c:out value="${userForm.username}"></c:out></td>
                               </tr>
                               <tr>
                                   <td>Password</td>
                                   <td>
                                       <c:if test="${edit}">
                                           <input
                                                   class="placeholder:italic placeholder:text-slate-400 block bg-white w-[300px] md:w-[400px] border border-slate-300 rounded-md p-2 shadow-sm focus:outline-none focus:border-sky-500 focus:ring-sky-500 focus:ring-1"
                                                   placeholder="Type new password here" type="password" name="password" id="password" required="required"/>
                                       </c:if>
                                       <c:if test="${!edit}">******</c:if>
                                   </td>
                               </tr>
                               <tr>
                                   <td>Gender</td>
                                   <td><c:out value="${userForm.gender}"></c:out></td>
                               </tr>
                               <tr>
                                   <td>School</td>
                                   <td><c:if test="${edit}">
                                       <input
                                               class="placeholder:italic placeholder:text-slate-400 block bg-white w-[300px] md:w-[400px] border border-slate-300 rounded-md p-2 shadow-sm focus:outline-none focus:border-sky-500 focus:ring-sky-500 focus:ring-1"
                                               placeholder="Type your School..." type="text" name="school" id="school" value="${userForm.school}" required="required" />
                                   </c:if>
                                       <c:if test="${!edit}"><c:out value="${userForm.school}"></c:out></c:if></td>
                               </tr>
                               </thead>
                           </table>
                       </div>
                   </div>
               </div>
               <div class="col-md-3"></div>
           </div>
        </div>
    </form:form>
</div>
    

<script>

//    document.getElementById('password').addEventListener('input', function(event) {
//        const inputValue = event.target.value;
//        if (/^[0-9,]*$/.test(inputValue)) {
//            event.target.value = inputValue;
//        } else {
//            event.target.value = inputValue.slice(0, -1);
//        }
//    });
</script>

</body>
</html>