import 'package:flutter/material.dart';

class WebHost extends StatefulWidget {
  const WebHost({super.key});

  @override
  State<WebHost> createState() => _WebHostState();
}

class _WebHostState extends State<WebHost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Web"),
    );
  }
}
