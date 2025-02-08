import 'package:flutter/material.dart';
import 'package:kay_scribble/widgets/custom_text_field.dart';
import 'package:kay_scribble/Paint_screen.dart' as package;

class JoinRoomScreen extends StatefulWidget {
  const JoinRoomScreen({super.key});

  @override
  _JoinRoomScreenState createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roomNameController = TextEditingController();
  late String? _maxRoundsValue;
  late String? _roomSizeValue;

  void joinRoom(){
    if(_nameController.text.isNotEmpty&&_roomNameController.text.isNotEmpty){
      Map data = {
        "nickname": _nameController.text,
        "name": _roomNameController.text,
      };
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              package.PaintScreen(data:data, screenFrom:'joinRoom')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Join Room", style: TextStyle(
            color: Colors.black, fontSize: 30,
          ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.08),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              Controller: _nameController,
              hintText: "Enter your name",
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              Controller: _roomNameController,
              hintText: "Enter Room Name",
            ),
          ),

          const SizedBox(height: 40),
          ElevatedButton(onPressed: (){},
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.blue),
                textStyle: WidgetStateProperty.all(const TextStyle(color: Colors.white)),
                minimumSize: WidgetStateProperty.all(Size(MediaQuery.of(context).size.width/2.5, 50))
            ), child: const Text(
              "Create",
              style: TextStyle(
                  color: Colors.white, fontSize: 16
              )),
          ),
        ],
      ),
    );
  }
}
