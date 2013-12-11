<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="sendMessage.aspx.cs" Inherits="SignalIRTest.sendMessage" MasterPageFile="~/Site.master" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">

</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <div class="container">
        <label for="messageAuthor">User sending message:</label>
        <input type="text" id="messageAuthor" /><br/>
        <label for="message">Message:</label>
        <input type="text" id="message" />
        <input type="button" id="sendmessage" value="Send" /><br />
        <input type="radio" name="color" value="red" checked />Red <input type="radio" name="color" value="green" /> Green <input type="radio" name="color" value="none" /> None


        <ul id="result">
        </ul>
    </div>
    <!--Script references. -->
    <!--Reference the jQuery library. -->
    <script src="Scripts/jquery-1.6.4.min.js" type="text/javascript"></script>
    <script src="Scripts/jquery.signalR-1.1.4.min.js" type="text/javascript"></script>
    <script src="signalr/hubs" type="text/javascript"></script>
    <!--Add script to update the page and send messages.--> 
    <script type="text/javascript">
        $(function () {
            // Declare a proxy to reference the hub. 
            var notifications = $.connection.notificationsHub;
            // Create a function that the hub can call to broadcast messages.
            notifications.client.addNumbers = function (result) {
                // Html encode display name and message. 
                var encodedName = $('<div />').text(result).html();
                //var encodedMsg = $('<div />').text(message).html();
                // Add the message to the page. 
                $('#result').append('<li><strong>' + encodedName
                    + '</strong></li>');
            };


            // Start the connection.
            $.connection.hub.start().done(function () {
                $('#sendmessage').click(function () {
                    // Call the Send method on the hub. 
                    notifications.server.sendNotification($('#messageAuthor').val(), $('#message').val(), $("input:radio[name=color]:checked").val());
                    // Clear text box and reset focus for next comment. 
                    $('#message').val('').focus();
                });
            });
        });
    </script>
</asp:Content>
    