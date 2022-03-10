import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lesson3/model/constant.dart';
import 'package:lesson3/model/photomemo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lesson3/viewscreen/view/webimage.dart';

class SharedWithScreen extends StatelessWidget {
  static const routeName = '/sharedWithScreen';

  final List<PhotoMemo> photoMemoList;
  final User user;

  const SharedWithScreen(
      {required this.photoMemoList, required this.user, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var constant = Constant;
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared With : ${user.email}'),
      ),
      //body: Text('Shared with : ${user.email} ${photoMemoList.length}'),
      body: SingleChildScrollView(
        child: photoMemoList.isEmpty
            ? Text(
                'No PhotoMemo shared with me',
                style: Theme.of(context).textTheme.headline6,
              )
            : Column(
                children: [
                  for (var photoMemo in photoMemoList)
                    Card(
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: WebImage(
                                url: photoMemo.photoURL,
                                context: context,
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                              ),
                            ),
                            Text(
                              photoMemo.title,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            Text(
                              photoMemo.memo,
                            ),
                            Text('Created By: ${photoMemo.createdBy}'),
                            Text('Created at: ${photoMemo.timestamp}'),
                            Text('Shared Wtih: ${photoMemo.sharedwith}'),
                            Constant.devMode
                                ? Text('Image Labels: ${photoMemo.imageLabels}')
                                : const SizedBox(
                                    height: 1.0,
                                  ),
                          ],
                        ),
                      ),
                    )
                ],
              ),
      ),
    );
  }
}
