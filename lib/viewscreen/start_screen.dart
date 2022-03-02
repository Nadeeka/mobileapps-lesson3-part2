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
  final formKey = GlobalKey<FormState>();
  late _Controller con;

  @override
  void initState() {
    super.initState();
    con = _Controller(this);
  }

  void render(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Text(
              'PhotoMemo',
              style: Theme.of(context).textTheme.headline3,
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Email Address',
              ),
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              validator: con.validateEmail,
              onSaved: con.saveEmail,
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
              autocorrect: false,
              obscureText: true,
              validator: con.validatePassword,
              onSaved: con.savePassword,
            ),
            ElevatedButton(
              onPressed: con.signin,
              child: Text(
                'Sign In',
                style: Theme.of(context).textTheme.button,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Controller {
  late _StartState state;
  String? email;
  String? password;
  _Controller(this.state);

  void signin() {
    FormState? currentState = state.formKey.currentState;
    if (currentState == null) return;
    if (!currentState.validate()) return;
    currentState.save();
  }

  String? validateEmail(String? value) {
    if (value == null) {
      return 'No email provided';
    } else if (!(value.contains('@') && value.contains('.'))) {
      return 'Invalid email format';
    } else {
      return null;
    }
  }

  void saveEmail(String? value) {
    if (value != null) {
      email = value;
    }
  }

  String? validatePassword(String? value) {
    if (value == null) {
      return 'password not provided';
    } else if (value.length < 6) {
      return 'password too short';
    } else {
      return null;
    }
  }

  void savePassword(String? value) {
    if (value != null) {
      password = value;
    }
  }
}
