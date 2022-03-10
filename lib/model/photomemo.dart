enum PhotoSource { camera, gallery }

enum DocKeyPhotoMemo {
  createdBy,
  title,
  memo,
  photoFilename,
  photoURL,
  timestamp,
  imaLabel,
  sharedwith
}

class PhotoMemo {
  String? docId; // Firestore auto-generated id
  late String createdBy;
  late String title;
  late String memo;
  late String photoFilename; // image/ photo file at Cloud Storage
  late String photoURL; // URL of image
  DateTime? timestamp;
  late List<dynamic> imageLabels; // ML generated image labels
  late List<dynamic> sharedwith;

  PhotoMemo({
    this.docId,
    this.createdBy = '',
    this.title = '',
    this.memo = '',
    this.photoFilename = '',
    this.photoURL = '',
    this.timestamp,
    List<dynamic>? imageLabels,
    List<dynamic>? sharedwith,
  }) {
    this.imageLabels = imageLabels == null ? [] : [...imageLabels];
    this.sharedwith = sharedwith == null ? [] : [...sharedwith];
  }

  PhotoMemo.clone(PhotoMemo p) {
    docId = p.docId;
    createdBy = p.createdBy;
    title = p.title;
    memo = p.memo;
    photoFilename = p.photoFilename;
    photoURL = p.photoURL;
    timestamp = p.timestamp;
    sharedwith = [...p.sharedwith];
    imageLabels = [...p.imageLabels];
  }

  //a.copyFrom(b) ==> a = b

  void copyFrom(PhotoMemo p) {
    docId = p.docId;
    createdBy = p.createdBy;
    title = p.title;
    memo = p.memo;
    photoFilename = p.photoFilename;
    photoURL = p.photoURL;
    timestamp = p.timestamp;
    sharedwith.clear();
    sharedwith.addAll(p.sharedwith);
    imageLabels.clear();
    imageLabels.addAll(p.imageLabels);
  }

  //serialization
  Map<String, dynamic> toFireStoreDoc() {
    return {
      DocKeyPhotoMemo.title.name: title,
      DocKeyPhotoMemo.createdBy.name: createdBy,
      DocKeyPhotoMemo.memo.name: memo,
      DocKeyPhotoMemo.photoFilename.name: photoFilename,
      DocKeyPhotoMemo.photoURL.name: photoURL,
      DocKeyPhotoMemo.timestamp.name: timestamp,
      DocKeyPhotoMemo.sharedwith.name: sharedwith,
      DocKeyPhotoMemo.imaLabel.name: imageLabels,
    };
  }

  //deserialization

  static PhotoMemo? fromFireStoreDoc({
    required Map<String, dynamic> doc,
    required String docId,
  }) {
    return PhotoMemo(
      docId: docId,
      createdBy: doc[DocKeyPhotoMemo.createdBy.name] ??= 'N/A',
      title: doc[DocKeyPhotoMemo.title.name] ??= 'N/A',
      memo: doc[DocKeyPhotoMemo.memo.name] ??= 'N/A',
      photoFilename: doc[DocKeyPhotoMemo.photoFilename.name] ??= 'N/A',
      photoURL: doc[DocKeyPhotoMemo.photoURL.name] ??= 'N/A',
      sharedwith: doc[DocKeyPhotoMemo.sharedwith.name] ??= [],
      imageLabels: doc[DocKeyPhotoMemo.imaLabel.name] ??= [],
      timestamp: doc[DocKeyPhotoMemo.timestamp.name] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              doc[DocKeyPhotoMemo.timestamp.name].millisecondsSinceEpoch,
            )
          : DateTime.now(),
    );
  }

  static String? validateTitle(String? value) {
    return (value == null || value.trim().length < 3)
        ? 'Title too short'
        : null;
  }

  static String? validateMemo(String? value) {
    return (value == null || value.trim().length < 5) ? 'Memo too short' : null;
  }

  static String? validateSharedWith(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    List<String>? emailList =
        value.trim().split(RegExp('(,|;|) +')).map((e) => e.trim()).toList();
    for (String e in emailList) {
      if (e.contains('@') && e.contains('.')) {
        continue;
      } else {
        return 'Invalid email address found: comma, semmicolon, space separated list';
      }
    }
  }
}
