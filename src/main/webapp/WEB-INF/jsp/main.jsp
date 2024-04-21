<%-- Document : Main Created on : Mar 19, 2024, 12:59:43 PM Author : Sarveashwaran --%>


    <%@page import="java.util.List" %>
        <%@page import="com.app.model.Chat" %>
            <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
                <%@page contentType="text/html" pageEncoding="UTF-8" %>
                    <!DOCTYPE html>
                    <html>

                    <head>
                        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                        <title>Rhythmiq Chat View</title>
                        <script src="https://cdn.tailwindcss.com"></script>
                        <link rel="stylesheet"
                            href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
                        <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script> -->
                        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

                        <style>
                            .chatAnchor {
                                text-decoration: none;
                                font-weight: bold;
                                padding: 5px;
                            }

                            .chatAnchor:hover {
                                text-decoration: none;
                            }

                            #profileLink {
                                cursor: pointer;
                            }

                            #chatBox {
                                position: relative;
                                text-align: center;
                                width: 100%;
                                padding-top: 0px;
                                margin-top: 0px;
                                padding-left: 100px;
                                padding-right: 50px;
                                height: auto;

                            }

                            .messageContainer {
                                display: flex;
                                align-items: flex-start;
                            }

                            .avatar {
                                width: 25px;
                                height: 25px;
                                margin-right: 10px;
                                /* Adjust margin as needed */
                            }

                            .username {
                                font-weight: bold;
                                margin-bottom: 5px;
                                /* Adjust margin as needed */
                            }

                            .message {
                                text-align: left;
                            }

                            .buttonContainer {
                                display: flex;
                                justify-content: center;
                                margin-top: 10px;
                                /* Adjust margin as needed */
                            }

                            .regenerateButton,
                            .transcribeButton {
                                margin: 0 5px;
                                /* Adjust margin as needed */
                                padding: 5px 10px;
                                /* Adjust padding as needed */
                                font-size: 14px;
                                /* Adjust font size as needed */
                                border: 1px solid #ccc;
                                /* Add border */
                                border-radius: 4px;
                                /* Optional: Add border radius */
                                background-color: #fff;
                                /* Optional: Set background color */
                                cursor: pointer;
                                /* Optional: Add pointer cursor */
                            }

                            .regenerateButton:hover,
                            .transcribeButton:hover {
                                background-color: #f0f0f0;
                                /* Optional: Change background color on hover */
                            }

                            .chat-box {
                                height: 400px;
                                /* Set the height of the chat box */
                                width: 700px;
                                overflow-y: auto;
                                /* Allow vertical scrolling */
                                padding: 10px;
                                border-radius: 10px;
                            }
                        </style>
                        <script>
                            var clearFirstTime = false;
                            var title = null;
                            function clear() {
                                $('#chatBox').html(''); // Clear the chat box
                            }

                            function handleKeyPress(event) {
                                // Check if the Enter key was pressed
                                if (event.key === 'Enter') {
                                    // Call your desired function here
                                    var inputValue = document.getElementById('message').value;
                                    if (inputValue.trim() !== '') {
                                        // Call your desired function here
                                        send();
                                    }

                                }
                            }
                            function redirectToNewPage() {
                                // Redirect to the new page
                                window.location.href = "<%=request.getContextPath()%>/profile";
                            }

                            function send(fromHistory) {
                                var msg = $('#message').val(); // get text from input
                                if ($.trim(msg).length > 0) { // validate text present
                                    if (!clearFirstTime) {
                                        $('#chatBox').html(''); // Clear the chat box initial welcome message
                                        clearFirstTime = true;
                                    }

                                    // Show loading modal
                                    if (!fromHistory) {
                                        console.log("modal opened");
                                        $('#loadingModal').modal('show');
                                    }

                                    $('#chatBox').append('<div class="messageContainer"><img src="<%=request.getContextPath()%>/images/bot.png" class="avatar" /><div><p class="username">RhythmiQ</p><p class="message">' + msg + '</p></div><br></div>');

                                    // Send the message to the backend
                                    $.ajax({
                                        url: '<%=request.getContextPath()%>/api/message',
                                        type: 'POST',
                                        contentType: 'application/json',
                                        data: JSON.stringify({ message: msg }),
                                        success: function (response) {

                                            $('#chatBox').append('<br><div class="messageContainer" id="audio_msg_title"><img src="<%=request.getContextPath()%>/images/bot.png" class="avatar"/><div><p class="username">RhythmiQ</p></div><br></div>' +
                                                '<audio id="audio_msg" controls>' +
                                                '<source src="${pageContext.request.contextPath}' + response.message + '" type="audio/wav">' +
                                                '<source src="${pageContext.request.contextPath}' + response.message + '" type="audio/mpeg">' +
                                                'Your browser does not support the audio element.</audio>');
                                            $('#chatBox').append('<div class="buttonContainer"><button class="regenerateButton" onclick="generate()">Regenerate</button><button class="transcribeButton" onclick="transcribe()">Transcribe</button></div>');
                                            $('#message').val('');
                                        },
                                        error: function () {
                                            // Handle errors here
                                            alert('Error sending message');
                                        },
                                        complete: function () {
                                            setTimeout(() => {
                                                $('#loadingModal').modal('hide');
                                            }, 1000);

                                        }
                                    });
                                }
                            }



                            function generate() {
                                $('#loadingModal').modal('hide');
                                $('#audio_msg_title').remove();
                                $('#audio_msg').remove();
                                $('#chatBox').find('br').remove();
                                $('.regenerateButton').hide();
                                $('.transcribeButton').hide();
                                $('#loadingModal').modal('show');
                                setTimeout(function () {
                                    // Hide loading modal

                                    $('#chatBox').append('<br><div class="messageContainer" id="audio_msg_title"><img src="<%=request.getContextPath()%>/images/bot.png" class="avatar" /><div><p class="username">RhythmiQ</p></div><br></div>' +
                                        ' <audio id="audio_msg" controls> <source src="${pageContext.request.contextPath}/music/audio.mp3" type="audio/ogg"> <source src="${pageContext.request.contextPath}/music/audio.mp3" type="audio/mpeg"> Your browser does not support the audio element.</audio>');
                                    $('.buttonContainer').remove();
                                    // $('.buttonContainer').remove();
                                    $('#chatBox').append('<br><div class="buttonContainer"><button class="regenerateButton" onclick="generate()">Regenerate</button><button class="transcribeButton" onclick="transcribe()">Transcribe</button></div>');

                                    $('#message').val('');

                                    $('#loadingModal').modal('hide');
                                    $('.regenerateButton').show();
                                    $('.transcribeButton').show();
                                }, 2000); // 1 minute in milliseconds

                            }

                            function transcribe(fromHistory) {
                                if (!fromHistory) {
                                    $('#transcribeModal').modal('show');
                                }
                                setTimeout(function () {
                                    // Hide loading modal
                                    $('#transcribeModal').modal('hide');

                                    $('#chatBox').append('<br><div class="messageContainer"><img src="<%=request.getContextPath()%>/images/bot.png" class="avatar" /><div><p class="username">RhythmiQ</p></div><br></div>' +
                                        '<div><embed id="pdfEmbed" src="${pageContext.request.contextPath}/music/music.pdf#toolbar=0" type="application/pdf" width="400" height="150" ><br /><button class="regenerateButton" onclick="openPdfInNewTab()"  style="float:left" >Open Pdf</button><div style="clear:both"></div></div>');

                                    $('#message').val('');
                                    $('.buttonContainer').remove();
                                    if (!fromHistory) {
                                        fetch('/save-data', {
                                            method: 'POST',
                                            body: JSON.stringify({ title: title }),
                                            headers: {
                                                'Content-Type': 'application/json'
                                            }
                                        }).then(res => res.json()).then(json => {

                                        }).catch(e => {
                                            console.log(e)
                                        }).finally(() => {

                                            fetch('/main').then(res => res.text()).then(html => {
                                                $('#history_area').html($(html).find('#history_area').html());
                                            });

                                        });
                                    }


                                }, (fromHistory ? 1 : 2000)); // 1 minute in milliseconds

                                var chatbox = document.getElementById("message");
                                chatbox.disabled = true;

                            }

                            function openPdfInNewTab() {
                                var pdfSrc = $('#pdfEmbed').attr('src');
                                window.open(pdfSrc, '_blank');
                            }

                            function handleHistoryClick(chatId, text) {
                                clearFirstTime = false;
                                var chatbox = document.getElementById("message");
                                chatbox.disabled = false;
                                $('#message').val(text);
                                send(true);
                            }

                        </script>
                    </head>

                    <body>
                        <%--<embed src="${pageContext.request.contextPath}/music/music.pdf" type="application/pdf"
                            width="100%" height="100%">--%>

                            <%--<audio controls>
                                <source src="${pageContext.request.contextPath}/music/audio.mp3" type="audio/ogg">
                                <source src="${pageContext.request.contextPath}/music/audio.mp3" type="audio/mpeg">
                                Your browser does not support the audio element.
                                </audio>
                                <a href="<%=request.getContextPath()%>/music/audio.mp3" download>Download Audio</a>--%>

                                <div class="w-full h-screen flex flex-row items-center justify-center">
                                    <div class="w-4/6 h-screen  flex flex-col justify-between items-center">
                                        <div
                                            class="bg-gray-300 drop-shadow-lg w-full h-20 flex flex-row justify-between p-2">
                                            <img src="<%=request.getContextPath()%>/images/logo2.jpg"
                                                class="w-[174px] h-[72px]" alt="" srcset="" />
                                            <img id="profileLink" style="width:60px; height: 60px; border-radius: 50%;"
                                                onclick="redirectToNewPage()"
                                                src="<%=request.getContextPath()%>/images/profile.jpg"
                                                class="w-[72px] h-[72px]" alt="" srcset="" />
                                        </div>
                                        <div class="text-black chat-box" id="chatBox">
                                            <p style="width: 100%; text-align: center;padding-top:6%;">
                                                How Can I Help You Today ?
                                            </p>
                                        </div>
                                        <div
                                            class="w-full h-16 p-2 flex flex-row items-center justify-center space-x-1">
                                            <script>
                                                function showAlert() {
                                                    $('#chatBox').html('<p style="width: 100%; text-align: center;padding-top:6%;"> How Can I Help You Today ?</p>'); // Clear the chat box
                                                    var chatbox = document.getElementById("message");
                                                    chatbox.disabled = false;
                                                    clearFirstTime = false;
                                                }

                                            </script>
                                            <button
                                                class="rounded-full bg-white h-10 w-10 border border-black text-white p-2 flex items-center justify-center"
                                                onclick="showAlert()">
                                                <svg class="h-7 w-7" width="64px" height="64px" viewBox="0 0 32 32"
                                                    version="1.1" xmlns="http://www.w3.org/2000/svg"
                                                    xmlns:xlink="http://www.w3.org/1999/xlink"
                                                    xmlns:sketch="http://www.bohemiancoding.com/sketch/ns"
                                                    fill="#000000">
                                                    <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                                                    <g id="SVGRepo_tracerCarrier" stroke-linecap="round"
                                                        stroke-linejoin="round"></g>
                                                    <g id="SVGRepo_iconCarrier">
                                                        <title>plus</title>
                                                        <desc>Created with Sketch Beta.</desc>
                                                        <defs> </defs>
                                                        <g id="Page-1" stroke="none" stroke-width="1" fill="none"
                                                            fill-rule="evenodd" sketch:type="MSPage">
                                                            <g id="Icon-Set" sketch:type="MSLayerGroup"
                                                                transform="translate(-360.000000, -1035.000000)"
                                                                fill="#000000">
                                                                <path
                                                                    d="M388,1053 L378,1053 L378,1063 C378,1064.1 377.104,1065 376,1065 C374.896,1065 374,1064.1 374,1063 L374,1053 L364,1053 C362.896,1053 362,1052.1 362,1051 C362,1049.9 362.896,1049 364,1049 L374,1049 L374,1039 C374,1037.9 374.896,1037 376,1037 C377.104,1037 378,1037.9 378,1039 L378,1049 L388,1049 C389.104,1049 390,1049.9 390,1051 C390,1052.1 389.104,1053 388,1053 L388,1053 Z M388,1047 L380,1047 L380,1039 C380,1036.79 378.209,1035 376,1035 C373.791,1035 372,1036.79 372,1039 L372,1047 L364,1047 C361.791,1047 360,1048.79 360,1051 C360,1053.21 361.791,1055 364,1055 L372,1055 L372,1063 C372,1065.21 373.791,1067 376,1067 C378.209,1067 380,1065.21 380,1063 L380,1055 L388,1055 C390.209,1055 392,1053.21 392,1051 C392,1048.79 390.209,1047 388,1047 L388,1047 Z"
                                                                    id="plus" sketch:type="MSShapeGroup"> </path>
                                                            </g>
                                                        </g>
                                                    </g>
                                                </svg>
                                            </button>
                                            <label
                                                class="relative block w-5/6 flex flex-row justify-center items-center">
                                                <input
                                                    class="placeholder:italic placeholder:text-slate-400 block bg-white w-full border border-slate-300 rounded-md py-2 pr-9 pl-3 shadow-sm focus:outline-none focus:border-sky-500 focus:ring-sky-500 focus:ring-1 sm:text-sm"
                                                    placeholder="How you want your music ?" type="text" name="search"
                                                    id="message" onkeypress="handleKeyPress(event)" />
                                                <button class="flex items-center justify-center" onclick="send()">
                                                    <span class="absolute inset-y-0 right-0 flex items-center pr-2">
                                                        <svg width="36px" height="23px"" viewBox=" 0 0 24 24"
                                                            xmlns="http://www.w3.org/2000/svg" fill="#1E7ED7">
                                                            <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                                                            <g id="SVGRepo_tracerCarrier" stroke-linecap="round"
                                                                stroke-linejoin="round"></g>
                                                            <g id="SVGRepo_iconCarrier">
                                                                <path
                                                                    d="M2.996 12.5l-1.157 8.821 20.95-8.821-20.95-8.821zm16.028-.5H3.939l-.882-6.724zM3.939 13h15.085L3.057 19.724z">
                                                                </path>
                                                                <path fill="none" d="M0 0h24v24H0z"></path>
                                                            </g>
                                                        </svg>
                                                    </span>
                                                </button>
                                            </label>
                                        </div>
                                    </div>
                                    <div class="w-2/6 shadow-md h-screen flex flex-col px-2 py-4 justify-between items-center"
                                        id="history_area">
                                        <a style="margin-left: 20px; padding: 4px;"
                                            class="bg-[orange] text-white  rounded-[5px]"
                                            href="http://localhost:8080/logout">Logout</a>
                                        <h1 class="text-black bg-[#CDFD9F] w-2/3 text-center">Chat History</h1>
                                        <div class="flex flex-col justify-start w-2/3 space-y-6 h-4/6">
                                            <div class="flex flex-col">
                                                <span>History</span>
                                                <div class="rounded-[5px] h-20 border border-black"
                                                    style="overflow: auto;height:300px">
                                                    <ul>
                                                        <% List<Chat> today = (List<Chat>)
                                                                request.getAttribute("today");
                                                                for (Chat chat : today) {
                                                                %>
                                                                <li style="padding: 10px;"><a href="#"
                                                                        class="chatAnchor" onclick="{
                                                                                    event.preventDefault();
                                                                                    handleHistoryClick(<%=chat.getId()%>, '<%=chat.getTitle()%>')
                                                                                }">
                                                                        <%=chat.getTitle()%>
                                                                    </a></li>
                                                                <% } %>
                                                    </ul>
                                                </div>
                                            </div>

                                        </div>

                                        <!--        <button class="bg-[#0059D6] text-white w-5/6 h-10 rounded-[10px]">
                            View All
                        </button>-->
                                    </div>
                                </div>
                                <script src="<%=request.getContextPath()%>/js/custom.js"></script>


                                <!-- Loading Modal -->
                                <div class="modal fade" id="loadingModal" tabindex="-1" role="dialog"
                                    aria-labelledby="loadingModalLabel" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered" role="document">
                                        <div class="modal-content">
                                            <div class="modal-body">
                                                <div class="spinner-border text-primary" role="status">
                                                    <span class="sr-only">Loading...</span>
                                                </div>
                                                <p>Your music is being composed...</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal fade" id="transcribeModal" tabindex="-1" role="dialog"
                                    aria-labelledby="transcribeModalLabel" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered" role="document">
                                        <div class="modal-content">
                                            <div class="modal-body">
                                                <div class="spinner-border text-primary" role="status">
                                                    <span class="sr-only">Please wait...</span>
                                                </div>
                                                <p>Transcribing...</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script> -->

                                <script
                                    src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
                                <script
                                    src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

                    </body>

                    </html>