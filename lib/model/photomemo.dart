class PhotoMemo {
  String? docId; // Firestore auto-generated id
  late String createdBy;
  late String title;
  late String memo;
  late String photoFilename; // image/ photo file at Cloud Storage
  late String photoURL; // URL of image
  DateTime? timestamp;
  late List<dynamic> imageLabels; // ML generated image labels
  late List<dynamic> sharedWith;

  PhotoMemo({
    this.docId,
    this.createdBy = '',
    this.title = '',
    this.memo = '',
    this.photoFilename = '',
    this.photoURL = '',
    this.timestamp,
    List<dynamic>? imageLabels,
    List<dynamic>? sharedWith,
  }) {
    this.imageLabels = imageLabels == null ? [] : [...imageLabels];
    this.sharedWith = sharedWith == null ? [] : [...sharedWith];
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
