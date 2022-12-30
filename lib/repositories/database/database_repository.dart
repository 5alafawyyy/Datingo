import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datingo/models/user_model.dart';
import 'package:datingo/repositories/storage/storage_repository.dart';

import 'base_database_repository.dart';

class DatabaseRepository extends BaseDatabaseRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Stream<User> getUser() {
    return _firebaseFirestore
        .collection('users')
        .doc('oA1E82geHxaCtAJTYfK7')
        .snapshots()
        .map((snap) => User.fromSnapshot(snap));
  }

  @override
  Future<void> updateUserPictures(String imageName) async {
    String downloadUrl = await StorageRepository().getDownloadUrl(imageName);

    return _firebaseFirestore
        .collection('users')
        .doc('oA1E82geHxaCtAJTYfK7')
        .update({
      'imageUrls': FieldValue.arrayUnion([downloadUrl])
    });
  }
}
