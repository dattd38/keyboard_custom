import 'package:custom_keyboard/custom_keyboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Keyboard'),
      ),
      body: const Keyboard(),
    ));
  }
}

class Keyboard extends StatefulWidget {
  const Keyboard({super.key});

  @override
  State<Keyboard> createState() => _KeyboardState();
}

class _KeyboardState extends State<Keyboard> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        readOnly: true,
        controller: _controller,
        onChanged: (value) {
          _controller.text = value;
        },
        keyboardType: TextInputType.none,
        showCursor: true,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8.0),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.green),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.green,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.green,
              width: 1.0,
            ),
          ),
        ),
        onTap: () {
          showModalBottomSheet(
              backgroundColor: Colors.transparent,
              barrierColor: Colors.transparent,
              context: context,
              builder: (_) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFd1d4dd),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white70,
                        spreadRadius: 5,
                        blurRadius: 2,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.26,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 4.0, bottom: 8.0, left: 8.0, right: 8.0),
                        child: _keyboard(),
                      )),
                );
              });
        },
      ),
    );
  }

  Widget _keyboard() {
    return DynamicKeyboard(
      theme: KeyboardTheme(
        borderColor: Colors.transparent,
        borderWidth: 1.0,
        operatorColor: const Color(0xFFe1e7e7),
        operatorStyle: const TextStyle(fontSize: 20, color: Color(0xFFa2a4a5)),
        commandColor: const Color(0xFFaeb2bf),
        commandStyle: const TextStyle(fontSize: 24, color: Color(0xFF212121)),
        numColor: Colors.white,
        numStyle: const TextStyle(fontSize: 24, color: Color(0xff212121)),
      ),
      onDone: () {
        debugPrint(_controller.text);
        Navigator.pop(context);
      },
      controller: _controller,
    );
  }
}
