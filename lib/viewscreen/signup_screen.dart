import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signUpScreen';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUpScreen> {
  var formKey = GlobalKey<FormState>();
  late _Controller con;

  @override
  void initState() {
    super.initState();
    con = _Controller(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Account'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Text(
                  'Create a new account',
                  style: Theme.of(context).textTheme.headline5,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  validator: con.validateEmail,
                  onSaved: con.saveEmail,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter password',
                  ),
                  autocorrect: false,
                  obscureText: true,
                  validator: con.validatePassword,
                  onSaved: con.savePassword,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Confirm password',
                  ),
                  autocorrect: false,
                  obscureText: true,
                  validator: con.validatePassword,
                  onSaved: con.saveConfirmPassword,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                ElevatedButton(
                  onPressed: con.signUp,
                  child: Text(
                    'Sign Up',
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Controller {
  _SignUpState state;
  _Controller(this.state);

  String? email;
  String? password;
  String? confirmPassword;

  void signUp() {}

  String? validateEmail(String? value) {
    if (value == null || !(value.contains('@') && value.contains('.'))) {
      return 'Invalid Email';
    }
  }

  void saveEmail(String? value) {
    email = value;
  }

  String? validatePassword(String? value) {
    if (value == null || value.length < 6) {
      return 'Password too short (min 6 chars)';
    } else {
      return null;
    }
  }

  void savePassword(String? value) {
    password = value;
  }

  void saveConfirmPassword(String? value) {
    confirmPassword = value;
  }
}
