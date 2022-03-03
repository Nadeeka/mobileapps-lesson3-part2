import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lesson3/controller/auth_controller.dart';
import 'package:lesson3/model/constant.dart';
import 'package:lesson3/viewscreen/addphotomemo_screen.dart';
import 'package:lesson3/viewscreen/view/view_util.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({required this.user, Key? key}) : super(key: key);
  static const routeName = '/userHomeScreen';

  final User user;

  @override
  State<StatefulWidget> createState() {
    return _UserHomeState();
  }
}

class _UserHomeState extends State<UserHomeScreen> {
  late _Controller con;
  late String email;
  @override
  void initState() {
    super.initState();
    con = _Controller(this);
    email = widget.user.email ?? 'No email';
  }

  void render(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('User Home'),
        ),
        drawer: Drawer(
            child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: const Icon(
                Icons.person,
                size: 70.0,
              ),
              accountName: const Text('no profile'),
              accountEmail: Text(email),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: const Text('Sign Out'),
              onTap: con.signOut,
            ),
          ],
        )),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: con.addButton,
        ),
        body: Text('User Home for $email'),
      ),
    );
  }
}

class _Controller {
  _UserHomeState state;
  _Controller(this.state);

  void addButton() {
    Navigator.pushNamed(state.context, AddPhotoMemoScreen.routeName,
        arguments: {ArgKey.user: state.widget.user});

    //Navigate to AddPhotoMemoScreen
  }

  Future<void> signOut() async {
    try {
      await AuthController.signOut();
    } catch (e) {
      if (Constant.devMode) print('========sign out error: $e');
      showSnackBar(context: state.context, message: 'Sign out error $e');
    }
    Navigator.of(state.context).pop(); // close the drawer
    Navigator.of(state.context).pop(); // return to start screen
  }
}
