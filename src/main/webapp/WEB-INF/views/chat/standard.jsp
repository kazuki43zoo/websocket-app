<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Chat on WebSocket using Spring</title>
<link rel="stylesheet"
    href="${pageContext.request.contextPath}/resources/app/css/styles.css">

<script src="http://code.jquery.com/jquery-2.1.4.js"></script>

<script type="text/javascript">

    var uri = "ws://" + location.host + "${pageContext.request.contextPath}/ws/chat";

    var webSocket = null;

    function init() {
        $("[data-name='message']").keypress(press);
        open();
    }

    function open() {
        if (webSocket == null) {
            webSocket = new WebSocket(uri);
            webSocket.onmessage = onMessage;
        }
    }

    function onMessage(event) {
        if (event && event.data) {
            view(event.data);
        }
    }

    function press(event) {
        if (event && event.which == 13) {
            var message = $("[data-name='message']").val();
            if (message && webSocket) {
                webSocket.send(message);
                $("[data-name='message']").val("");
            }
        }
    }

    function view(message) {
        var chats = $("[data-name='chat']").find("div");
        while (chats.length >= 100) {
            chats = chats.last().remove();
        }
        var msgtag = $("<div>").text(message);
        $("[data-name='chat']").prepend(msgtag);
    }

    $(init);

</script>
</head>
<body>
    <div id="wrapper">
        <h1>Chat on WebSocket using Spring</h1>
        Message : <input type="text" data-name="message" size="100" />
        <hr />
        <div data-name="chat">
        </div>
    </div>
</body>
</html>
