<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Home</title>
<link rel="stylesheet"
    href="${pageContext.request.contextPath}/resources/app/css/styles.css">
</head>
<body>
    <div id="wrapper">
        <h1>Hello world!</h1>
        <p>The time on the server is ${serverTime}.</p>
        <ul>
            <li><a href="${pageContext.request.contextPath}/chat/stomp?roomId=1">Chat on STOMP over WebSocket</a></li>
            <li><a href="${pageContext.request.contextPath}/chat/standard">Chat on WebSocket</a></li>
        </ul>
    </div>
</body>
</html>
