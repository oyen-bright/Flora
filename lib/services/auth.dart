import 'package:firebase_auth/firebase_auth.dart';
import 'package:flora/models/models.dart';
import 'package:flutter/services.dart';
import 'package:flora/services/database.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AppUser _userFromFirebaseUser(User user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  Stream<AppUser> get user {
    return _auth.userChanges().map((User user) => _userFromFirebaseUser(user));
    //.map(_userFromFirebaseUser(user));
  }

  // Future signInAnon() async {
  //   try {
  //     UserCredential result = await _auth.signInAnonymously();
  //     User user = result.user;
  //     return _userFromFirebaseUser(user);
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  String getUserEmaill() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User user = _auth.currentUser;
    print(user.email.toString() + 'KDLFDSKFJSLFKJSKLFJSFKLJKL');
    return user.email.toString();
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      print("SUCESSFULLY GOTTEN USER" + user.uid);

      await DatabaseService(uId: user.uid)
          .updateUserData(userEmail: user.email, userId: user.uid);

      // await DatabaseService(uId: user.uid).updateUserMylist();
      // await DatabaseService(uId: user.uid).updateUserDownloadList();

      return _userFromFirebaseUser(user);
    } catch (e) {
      return e.code.toString();
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      return e.code.toString();
    }
  }

  Future getStartedCheck(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      print('this is the exception' + e.code);

      if (e.code == 'network-request-failed') {
        return null;
      } else if (e.code == 'wrong-password') {
        return true;
      } else if (e.code == 'too-many-requests') {
        return 'tooManyRequests';
      } else if (e.code == 'user-not-found') {
        return false;
      } else {
        return null;
      }
    }
  }

  Future signOut() async {
    try {
      print("object ${_auth.signOut()}");
      return await _auth.signOut();
    } catch (e) {
      print('sign out is not working ');
      print(e);
      return null;
    }
  }
}
