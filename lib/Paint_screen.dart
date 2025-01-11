import 'dart:io';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
class PaintScreen extends StatefulWidget {
  const PaintScreen({super.key});

  @override
  State<PaintScreen> createState() => _PaintScreenState();
}

class _PaintScreenState extends State<PaintScreen> {

  late IO.Socket _socket;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connect();
  }
  //socket io client connection
  void connect(){
    _socket = IO.io('http//');
  }

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}
