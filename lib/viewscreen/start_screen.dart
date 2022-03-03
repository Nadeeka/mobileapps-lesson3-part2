import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lesson3/controller/auth_controller.dart';
import 'package:lesson3/model/constant.dart';
import 'package:lesson3/viewscreen/userhome_screen.dart';
import 'package:lesson3/viewscreen/view/view_util.dart';
import 'package:lesson3/model/photomemo.dart';

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
  _StartState state;
  String? email;
  String? password;
  _Controller(this.state);

  void signin() async {
    FormState? currentState = state.formKey.currentState;
    if (currentState == null) return;
    if (!currentState.validate()) return;
    currentState.save();

    User? user;

    try {
      if (email == null || password == null) {
        throw 'email or password is null';
      }
      user = await AuthController.signIn(email: email!, password: password!);
      Navigator.pushNamed(
        state.context,
        UserHomeScreen.routeName,
        arguments: {ArgKey.user: user},
      );
    } catch (e) {
      if (Constant.devMode) print('********** Sign In Error: $e');
      showSnackBar(context: state.context, message: 'Sign In Error: $e');
    }
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
