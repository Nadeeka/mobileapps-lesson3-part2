import 'dart:io';
import 'package:uuid/uuid.dart';
import '../model/constant.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CloudStorageController {
  static Future<Map<ArgKey, String>> uploadPhotoFile({
    required File photo,
    String? filename,
    required String uid,
    required Function listener,
  }) async {
    filename ??= '${Constant.photoFileFolder}/$uid/${const Uuid().v1()}';
    UploadTask task = FirebaseStorage.instance.ref(filename).putFile(photo);
    task.snapshotEvents.listen((TaskSnapshot event) {
      int progress = (event.bytesTransferred / event.totalBytes * 100).toInt();
      listener(progress);
    });

    TaskSnapshot snapshot = await task;
    String downloadURL = await snapshot.ref.getDownloadURL();
    return {
      ArgKey.downloadURL: downloadURL,
      ArgKey.filename: filename,
    };
  }
}
