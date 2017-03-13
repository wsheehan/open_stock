// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/my_app/endpoint.ex":
import {Socket} from "phoenix"

// When you connect, you'll often need to authenticate the client.
// For example, imagine you have an authentication plug, `MyAuth`,
// which authenticates the session and assigns a `:current_user`.
// If the current user exists you can assign the user's token in
// the connection for use in the layout.
//
// In your "web/router.ex":
//
//     pipeline :browser do
//       ...
//       plug MyAuth
//       plug :put_user_token
//     end
//
//     defp put_user_token(conn, _) do
//       if current_user = conn.assigns[:current_user] do
//         token = Phoenix.Token.sign(conn, "user socket", current_user.id)
//         assign(conn, :user_token, token)
//       else
//         conn
//       end
//     end
//
// Now you need to pass this token to JavaScript. You can do so
// inside a script tag in "web/templates/layout/app.html.eex":
//
//     <script>window.userToken = "<%= assigns[:user_token] %>";</script>
//
// You will need to verify the user token in the "connect/2" function
// in "web/channels/user_socket.ex":
//
//     def connect(%{"token" => token}, socket) do
//       # max_age: 1209600 is equivalent to two weeks in seconds
//       case Phoenix.Token.verify(socket, "user socket", token, max_age: 1209600) do
//         {:ok, user_id} ->
//           {:ok, assign(socket, :user, user_id)}
//         {:error, reason} ->
//           :error
//       end
//     end
//
// Finally, pass the token on connect as below. Or remove it
// from connect if you don't care about authentication.

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

let connect = function(token) {
  let socket = new Socket(socket_url, { params: { token: token } });
  socket.connect();
  socket.onClose(function (e) {
    return console.log("CLOSE", e);
  });

  startListening(socket);
}

let startListening = function(socket) {
  let channel = socket.channel("iex:securities:AAPL", {})
  channel.join()
    .receive("ok", resp => { console.log("Joined successfully", resp) })

  channel.on("quote", function(msg) {
    console.log(msg);
  });

  // Heart Beat Message
  setInterval(() => {
    console.log("Heartbeat");
    let hearbeat_channel = socket.channel("phoenix", {"event": "heartbeat", "payload": {}, "ref": null});
    hearbeat_channel.join()
      .receive("ok", resp => { console.log("Heartbeat Successful", resp) })
  }, 20000)
}

export default socket
