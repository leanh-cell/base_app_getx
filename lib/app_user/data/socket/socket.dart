import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketUser {
  static final SocketUser _singleton = SocketUser._internal();

  SocketUser._internal();

  factory SocketUser() {
    return _singleton;
  }

  late IO.Socket socket;

  void connect() async {
    try {
      socket = IO.io('https://main.doapp.vn:6441', <String, dynamic>{
        "transports": ["websocket"],
        "autoConnect": false,
      });
      socket.connect();
      socket
          .onConnect((data) => print("on conected >>>>>>>>>>>>>>>>>>>>>>>>>>"));
    } catch (err) {
      print(err);
    }
  }

  void listenCustomerWithId(int? idCustomer, Function getData) {
    socket.on('chat:message_from_customer:$idCustomer', (data) async {
      print("vooooooooooooooo $idCustomer");
      getData(data);
    });
  }

  void listenUser(int? idCustomer, Function getData) {
    print("------------------------dang ngheeeee");
    socket.on('chat:message_from_user:$idCustomer', (data) async {
      getData(data);
    });
  }

  void listenCustomer(Function getData) {
    socket.on('chat:message_from_customer', (data) async {
      getData(data);
    });
  }

  void close() {
    socket.clearListeners();
    socket.close();
  }
}
