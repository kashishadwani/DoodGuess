
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class PaintScreen extends StatefulWidget {
  final Map data;
  final String screenFrom;
  const PaintScreen({super.key,required this.data, required this.screenFrom});

  @override
  _PaintScreenState createState() => _PaintScreenState();
}

class _PaintScreenState extends State<PaintScreen> {

  late IO.Socket _socket;
  String dataOfRoom = "";
  @override
  void initState() {

    super.initState();
    connect();
    print(widget.data);
  }
  //socket io client connection
  void connect(){
    _socket = IO.io('http://10.54.172.56:3000', <String, dynamic>{
      'transports':['websocket'],
      'autoConnect': false
    });

    _socket.connect();
    
    //listen to socket
    _socket.onConnect((data){
      print('connected to the server');
      if(widget.screenFrom =='createRoom'){
        _socket.emit('create-game', widget.data);
      }else{
        _socket.emit('join-game', widget.data);
      }
    });
    _socket.on('updateRoom', (roomData){
      setState(() {
        dataOfRoom = roomData.toString();
      });
      if(roomData['isJoin'] != true){
        //start the timer
      }
    });
    _socket.onConnectError((data) => print('Connection Error: $data'));
    _socket.onDisconnect((_) => print('Disconnected from server'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
