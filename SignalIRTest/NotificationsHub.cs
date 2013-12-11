using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.SignalR;

namespace SignalIRTest
{
    public class NotificationsHub: Hub
    {
        public void SendNotification(string author, string message, string color)
        {
            Clients.All.broadcastNotification(author, message, color);
        }
    }
}