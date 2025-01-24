import 'dart:io';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class PaintScreen extends StatefulWidget {
  final Map data;
  final String screenFrom;
  const PaintScreen({Key? key,required this.data, required this.screenFrom}): super(key: key);

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
    _socket = IO.io('http//10.54.33.169:3000', <String, dynamic>{
      'transports':['websocket'],
      'autoConnect': false
    });
    _socket.connect();

    if(widget.screenFrom =='createRoom'){
      _socket.emit('create_game', widget.data);
    }
    
    //listen to socket
    _socket.onConnect((data){
      print('connected');
      _socket.on('updateRoom', (roomData){
        setState(() {
          dataOfRoom = roomData;
        });
        if(roomData['isJoin'] != true){
          //start the timer
        }

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
