<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Chat on STOMP over WebSocket using Spring(in memory broker)</title>
<link rel="stylesheet"
    href="${pageContext.request.contextPath}/resources/app/css/styles.css">

<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/vendor/stomp/stomp.js"></script>

<script type="text/javascript">

    var uri = "ws://" + location.host + "${pageContext.request.contextPath}/stomp";
    var stompClient = null;

    function init() {
        $("[data-name='message']").keypress(press);
        open();
    }

    function open() {
        if (stompClient == null) {
            var webSocket = new WebSocket(uri);
            stompClient = Stomp.over(webSocket);
            stompClient.connect({}, function(frame) {
                stompClient.subscribe('/topic/chat/${param.roomId}', function(message){
                    view(message.body)
                });
            });
        }
    }

    function disconnect() {
        if (stompClient != null) {
            stompClient.disconnect();
        }
    }

    function press(event) {
        if (event && event.which == 13) {
            var message = $("[data-name='message']").val();
            if (message && stompClient) {
                stompClient.send("/app/chat/${param.roomId}", {}, message)
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
        <h1>Chat on STOMP over WebSocket using Spring(in memory broker)</h1>
        <h2>Room ${param.roomId}</h2>
        <hr />
        Message : <input type="text" data-name="message" size="100" />
        <hr />
        <div data-name="chat">
        </div>
    </div>
</body>
</html>
