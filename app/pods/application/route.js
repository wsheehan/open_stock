import Ember from 'ember';
import Socket from 'npm:phoenix-socket';

export default Ember.Route.extend({
  activate() {
    let username = "eada4ad55493b61365859339c4c383d3";
    let password = "4de15d2c4757c9eb733300e8c3691c36";

    $.ajax({
      type: "GET",
      url: "https://realtime.intrinio.com/auth",
      beforeSend: function(xhr) {
        xhr.setRequestHeader("Authorization", "Basic " + btoa(username + ":" + password));
      },
      success: function(token) {
        console.log("Successful Connnection");
        connect(token);
      },
      error: function(xhr, status, error) {
        console.error("Error connecting: ", error);
      }
    })

    let socket_url = "wss://realtime.intrinio.com/socket";

    let connect = (token) => {
      let socket = new Socket.Socket(socket_url, { params: { token: token } });
      socket.connect();
      socket.onClose(function (e) {
        return console.log("CLOSE", e);
      });

      // startListening(socket);
      this.set("openSocket", socket);
    }
  },
  actions: {
    listenToCompany(company) {
      let socket = this.get("openSocket");
      let channel = socket.channel("iex:securities:" + company, {})
      channel.join()
        .receive("ok", resp => { console.log("Joined " + company + " successfully", resp) })

      channel.on("quote", function(msg) {
        console.log(msg);
        if (msg.type === "ask") {
          Ember.$(".ticker-big-price-" + company).text(msg.price);
        }
      });

      // Heart Beat Message
      setInterval(() => {
        console.log("Heartbeat");
        let hearbeat_channel = socket.channel("phoenix", {"event": "heartbeat", "payload": {}, "ref": null});
        hearbeat_channel.join()
          .receive("ok", resp => { console.log("Heartbeat Successful", resp) })
      }, 20000)
    }
  }
});
