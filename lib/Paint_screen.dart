import 'dart:io';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class PaintScreen extends StatefulWidget {
  final Map data;
  final String screenFrom;
  PaintScreen({required this.data, required this.screenFrom});

  @override
  _PaintScreenState createState() => _PaintScreenState();
}

class _PaintScreenState extends State<PaintScreen> {

  late IO.Socket _socket;

  @override
  void initState() {

    super.initState();
    connect();
  }
  //socket io client connection
  void connect(){
    _socket = IO.io('http//10.54.33.169:3000', <String, dynamic>{
      'transports':['websocket'],
      'autoConnect': false
    });
    _socket.connect();
    
    //listen to socket
    _socket.onConnect((data){
      print('data');

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}
