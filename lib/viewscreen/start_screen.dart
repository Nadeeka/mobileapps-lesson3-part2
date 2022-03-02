import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  static const routeName = '/startScreen';
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StartState();
  }
}

class _StartState extends State<StartScreen> {
  late _controller con;

  @override
  void initState() {
    super.initState();
    con = _controller(this);
  }

  void render(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: const Text('Start Screen'),
    );
  }
}

class _controller {
  late _StartState state;
  _controller(this.state);
}
