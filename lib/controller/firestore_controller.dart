import 'package:lesson3/model/constant.dart';
import 'package:lesson3/model/photomemo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreController {
  static Future<String> addPhotoMemo({
    required PhotoMemo photoMemo,
  }) async {
    DocumentReference ref = await FirebaseFirestore.instance
        .collection(Constant.photoMemoCollection)
        .add(photoMemo.toFireStoreDoc());
    return ref.id; // doc id auto-generated
  }

  static Future<List<PhotoMemo>> getPhotoMemoList({
    required String email,
  }) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(Constant.photoMemoCollection)
        .where(DocKeyPhotoMemo.createdBy.name, isEqualTo: email)
        .orderBy(DocKeyPhotoMemo.timestamp.name, descending: true)
        .get();

    var result = <PhotoMemo>[];
    for (var doc in querySnapshot.docs) {
      if (doc.data() != null) {
        var document = doc.data() as Map<String, dynamic>;
        var p = PhotoMemo.fromFireStoreDoc(doc: document, docId: doc.id);
        if (p != null) result.add(p);
      }
    }
    return result;
  }

  static Future<void> updatePhotoMemo({
    required String docId,
    required Map<String, dynamic> update,
  }) async {
    await FirebaseFirestore.instance
        .collection(Constant.photoMemoCollection)
        .doc(docId)
        .update(update);
  }

  static Future<List<PhotoMemo>> searchImages({
    required String email,
    required List<String> searchLabel, //search
  }) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(Constant.photoMemoCollection)
        .where(DocKeyPhotoMemo.createdBy.name, isEqualTo: email)
        .where(DocKeyPhotoMemo.imaLabel.name, arrayContainsAny: searchLabel)
        .orderBy(DocKeyPhotoMemo.timestamp.name, descending: true)
        .get();

    var result = <PhotoMemo>[];
    for (var doc in querySnapshot.docs) {
      var p = PhotoMemo.fromFireStoreDoc(
          doc: doc.data() as Map<String, dynamic>, docId: doc.id);
      if (p != null) result.add(p);
    }

    return result;
  }

  static Future<void> deleteDoc({
    required String docId,
  }) async {
    await FirebaseFirestore.instance
        .collection(Constant.photoMemoCollection)
        .doc(docId)
        .delete();
  }
}
