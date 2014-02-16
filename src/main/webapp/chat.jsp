<%--
  Created by IntelliJ IDEA.
  User: radcortez
  Date: 10/10/13
  Time: 11:37 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>

<%
    out.print(request.getAttribute("text"));
%>

<br>

<div id="messages"></div>

<input id="text" type="text"/>
<button onclick="sendMessage(document.getElementById('text').value)">Send</button>

<script type="application/javascript">
    var webSocket;

    open();

    function open() {
        var contextRoot = "<% out.print(request.getContextPath()); %>";
        if (!webSocket) {
            webSocket = new WebSocket('ws://' + document.location.host + contextRoot + '/chatWebSocket');
            webSocket.onopen = onOpen;
            webSocket.onmessage = onMessage;
            webSocket.onclose = onClose;
        }
    }

    function onOpen() {
        sendMessage("Web client connected!")
    }

    function sendMessage(msg) {
        webSocket.send(msg);
    }

    function onMessage(evt) {
        var websocketMessages = document.getElementById('messages');
        websocketMessages.innerHTML = websocketMessages.innerHTML + evt.data + '<br>';
    }

    function onClose() {
        if (webSocket) {
            webSocket.close();
        }
    }
</script>

</body>
</html>
