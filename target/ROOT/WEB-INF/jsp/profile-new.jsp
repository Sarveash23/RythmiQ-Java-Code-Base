<%-- 
    Document   : Profile
    Created on : Mar 19, 2024, 1:00:14 PM
    Author     : Sarveashwaran
--%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
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
                background-image: url('/images/bg.jpg');
                background-size: cover;
                backdrop-filter: blur(10px);
                /* Adjust the blur radius as needed */
            }

            input[disabled], select[disabled]{
                background-color: #eee;

            }


        </style>
    </head>

    <body>
        <div class="h-screen flex pt-0 md:pt-2 justify-center items-center bg-cover no-repeat">
            
            <form:form method="POST" modelAttribute="userForm"  action="/profile" 
                       class="p-6 w-[320px] md:w-[575px] bg-white shadow-xl rounded-[10px] h-[500px] flex flex-col items-center justify-center space-y-6">
                <input type="hidden" name="id" value="${userForm.id}" />
                <h1 class="text-center text-4xl">Profile
                </h1>
                <div class="flex flex-col justify-center items-start space-y-1 md:space-y-6">
                    <div
                        class="flex flex-col md:flex-row justify-center md:justify-between items-start md:items-center space-y-4 md:space-y-0 space-x-0 md:space-x-4 w-[300px] md:w-[500px]">
                        <label for="username" class="text-sm md:text-xl">Username</label>
                        <input value="${userForm.username}" readonly disabled
                               class="placeholder:italic placeholder:text-slate-400 block bg-white w-[300px] md:w-[400px] border border-slate-300 rounded-md p-2 shadow-sm focus:outline-none focus:border-sky-500 focus:ring-sky-500 focus:ring-1"
                               placeholder="Type your Username..." type="text" name="username" id="username" />
                    </div>
                    <div
                        class="flex flex-col md:flex-row justify-center md:justify-between items-start md:items-center space-y-4 md:space-y-0 space-x-0 md:space-x-4 w-[300px] md:w-[500px]">
                        <label for="password" class="text-sm md:text-xl">Password</label>
                        <input ${!edit?'disabled':''} value="${edit?'':'****************'}"
                                                      class="placeholder:italic placeholder:text-slate-400 block bg-white w-[300px] md:w-[400px] border border-slate-300 rounded-md p-2 shadow-sm focus:outline-none focus:border-sky-500 focus:ring-sky-500 focus:ring-1"
                                                      placeholder="Type your Password..." type="password" name="password" id="password" />
                    </div>
                    <div
                        class="flex flex-col md:flex-row justify-center md:justify-between items-start md:items-center space-y-4 md:space-y-0 space-x-0 md:space-x-4 w-[300px] md:w-[500px]">
                        <label for="gender" class="text-sm md:text-xl">Gender</label>
                        <div class="bg-white w-[300px] md:w-[400px]">
                            <input disabled="true" value="${userForm.gender}"
                                                      class="placeholder:italic placeholder:text-slate-400 block bg-white w-[300px] md:w-[400px] border border-slate-300 rounded-md p-2 shadow-sm focus:outline-none focus:border-sky-500 focus:ring-sky-500 focus:ring-1"
                                                      type="text" name="gender" id="gender" />
                        </div>
                    </div>
                    <div
                        class="flex flex-col md:flex-row justify-center md:justify-between items-start md:items-center space-y-4 md:space-y-0 space-x-0 md:space-x-4 w-[300px] md:w-[500px]">
                        <label for="school" class="text-sm md:text-xl">School</label>
                        <input ${!edit?'disabled':''} value="${userForm.school}"
                                                      class="placeholder:italic placeholder:text-slate-400 block bg-white w-[300px] md:w-[400px] border border-slate-300 rounded-md p-2 shadow-sm focus:outline-none focus:border-sky-500 focus:ring-sky-500 focus:ring-1"
                                                      placeholder="Type your School..." type="text" name="school" id="school" />
                    </div>
                </div>
                <table>
                    <tr>
                        <td>
                            <c:if test="${edit}">
                                <button type="submit" class="bg-[#198754] text-white w-20 h-10 rounded-[5px]">
                                    Save
                                </button>
                            </c:if>
                            <c:if test="${!edit}">
                                <button type="button" onclick="{
                                            event.preventDefault();
                                            window.location = '<%=request.getContextPath()%>/edit-profile'
                                        }"  class="bg-[#0059D6] text-white w-20 h-10 rounded-[5px]">
                                    Edit
                                </button>
                            </c:if>

                        </td>
                        <td>
                            <button type="button" onclick="{
                                        event.preventDefault();
                                        window.location = '<%=request.getContextPath()%>/main'
                                    }" class="bg-[#ffc107] text-white w-20 h-10 rounded-[5px]">
                                Back
                            </button>
                        </td>
                    </tr>
                </table>             

            </form:form>
        </div>

    </body>

</html>
