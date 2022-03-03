import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lesson3/model/photomemo.dart';

class AddPhotoMemoScreen extends StatefulWidget {
  final User user;
  const AddPhotoMemoScreen({required this.user, Key? key}) : super(key: key);

  static const routeName = '/addPhotoMemoScreen';
  @override
  State<StatefulWidget> createState() {
    return _AddPhotoMemoState();
  }
}

class _AddPhotoMemoState extends State<AddPhotoMemoScreen> {
  late _Controller con;
  var formKey = GlobalKey<FormState>();
  File? photo;

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
        title: const Text('Add a New Memo'),
        actions: [
          IconButton(
            onPressed: con.save,
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
              child: photo == null
                  ? const FittedBox(child: Icon(Icons.photo_library))
                  : Image.file(photo!),
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Title'),
              autocorrect: true,
              validator: PhotoMemo.validateTitle,
              onSaved: con.saveTitle,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Memo'),
              autocorrect: true,
              validator: PhotoMemo.validateMemo,
              onSaved: con.saveMemo,
              keyboardType: TextInputType.multiline,
              maxLines: 6,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  hintText: 'Shared with (email list separated by space, ;)'),
              autocorrect: false,
              validator: PhotoMemo.validateSharedWith,
              onSaved: con.saveSharedWith,
              keyboardType: TextInputType.emailAddress,
              maxLines: 6,
            ),
          ],
        )),
      ),
    );
  }
}

class _Controller {
  _AddPhotoMemoState state;
  PhotoMemo tempMemo = PhotoMemo();
  _Controller(this.state);

  void save() {
    FormState? currentState = state.formKey.currentState;
    if (currentState == null || !currentState.validate()) {
      return;
    }
    currentState.save();
  }

  void saveTitle(String? value) {
    if (value != null) {
      tempMemo.title = value;
    }
  }

  void saveMemo(String? value) {
    if (value != null) {
      tempMemo.memo = value;
    }
  }

  void saveSharedWith(String? value) {
    if (value != null && value.trim().isEmpty) {
      var emailList =
          value.trim().split(RegExp('(,|; )+')).map((e) => e.trim()).toList();
      //tempMemo.sharedwith = emailList;
    }
  }
}
