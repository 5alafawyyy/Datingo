import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../models/models.dart';
import '/repositories/repositories.dart';

class DatabaseRepository extends BaseDatabaseRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Stream<User> getUser(String userId) {
    if (kDebugMode) {
      print('Getting user images from DB');
    }
    return _firebaseFirestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snap) => User.fromSnapshot(snap));
  }

  @override
  Stream<List<User>> getUsers(
    String userId,
    String gender,
  ) {
    return _firebaseFirestore
        .collection('users')
        .where('gender', isNotEqualTo: gender)
        .snapshots()
        .map((snap) {
      return snap.docs.map((doc) => User.fromSnapshot(doc)).toList();
    });
  }

  @override
  Future<void> createUser(User user) async {
    await _firebaseFirestore
        .collection('users')
        .doc(user.id)
        .set(user.toMap());
  }

  @override
  Future<void> updateUser(User user) async {
    return _firebaseFirestore
        .collection('users')
        .doc(user.id)
        .update(user.toMap())
        .then(
      (value) {
        if (kDebugMode) {
          print('User document updated.');
        }
      },
    );
  }

  @override
  Future<void> updateUserPictures(
    User user,
    String imageName,
  ) async {
    String downloadUrl = await StorageRepository().getDownloadURL(
      user,
      imageName,
    );

    return _firebaseFirestore.collection('users').doc(user.id).update(
      {
        'imageUrls': FieldValue.arrayUnion([downloadUrl])
      },
    );
  }
}
