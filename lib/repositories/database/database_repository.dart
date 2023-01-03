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
    User user,
  ) {
    List<String> userFilter = List.from(user.swipeLeft!)
      ..addAll(user.swipeRight!)
      ..add(user.id!);

    return _firebaseFirestore
        .collection('users')
        .where('gender', isEqualTo: 'Female')
        // .where(FieldPath.documentId, whereNotIn: userFilter)
        .snapshots()
        .map((snap) {
      return snap.docs.map((doc) => User.fromSnapshot(doc)).toList();
    });
  }

  @override
  Stream<List<Match>> getMatches(User user) {
    List<String> userFilter = List.from(user.matches!)..add('0');

    return _firebaseFirestore
        .collection('users')
        .where(FieldPath.documentId, whereIn: userFilter)
        .snapshots()
        .map((snap) {
      return snap.docs
          .map((doc) => Match.fromSnapshot(
                doc,
                user.id!,
              ))
          .toList();
    });
  }

  @override
  Future<void> createUser(User user) async {
    await _firebaseFirestore.collection('users').doc(user.id).set(user.toMap());
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

  @override
  Future<void> updateUserSwipe(
    String userId,
    String matchId,
    bool isSwipeRight,
  ) async {
    if (isSwipeRight) {
      await _firebaseFirestore.collection('users').doc(userId).update({
        'swipeRight': FieldValue.arrayUnion([matchId])
      });
    } else {
      await _firebaseFirestore.collection('users').doc(userId).update({
        'swipeLeft': FieldValue.arrayUnion([matchId])
      });
    }
  }

  @override
  Future<void> updateUserMatch(String userId, String matchId) async {
    // Update the current user document
    await _firebaseFirestore.collection('users').doc(userId).update(
      {
        'matches': FieldValue.arrayUnion([matchId]),
      },
    );

    // Add the match in the other user document too
    await _firebaseFirestore.collection('users').doc(matchId).update(
      {
        'matches': FieldValue.arrayUnion([userId]),
      },
    );
  }
}
