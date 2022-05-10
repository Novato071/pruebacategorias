import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:needs_customer/screens/screens.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/models.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> user;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  void onReady() {
    super.onReady();
    user = Rx<User?>(auth.currentUser);
    user.bindStream(auth.userChanges());
    ever(user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      print('Login Page');
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => HomeScreen());
    }
  }

  // Firebase user one-time fetch
  Future<User> get getUser async => auth.currentUser!;

  // Firebase user a realtime stream
  Stream<User?> get userStream => auth.authStateChanges();

  //Streams the firestore user from the firestore collection
  Stream<UserModel> streamFirestoreUser() {
    print('streamFirestoreUser()');

    return _db
        .doc('/users/${user.value!.uid}')
        .snapshots()
        .map((snapshot) => UserModel.fromMap(snapshot.data()!));
  }

  //get the firestore user from the firestore collection
  Future<UserModel> getFirestoreUser() {
    return _db.doc('/users/${user.value!.uid}').get().then(
        (documentSnapshot) => UserModel.fromMap(documentSnapshot.data()!));
  }

  //create the firestore user in users collection
  void _createUserFirestore(UserModel user, User _firebaseUser) {
    _db.doc('/users/${_firebaseUser.uid}').set(user.toJson());
    update();
  }

  void register(String email, String password) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((result) async {
        UserModel _newUser = UserModel(
          uid: result.user!.uid,
          email: result.user!.email!,
          name: 'Place Holder',
          photoUrl: 'url',
        );
        _createUserFirestore(_newUser, result.user!);
      });
    } catch (e) {
      Get.snackbar('About User', 'User-Mensagge',
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            'Creación de la cuenta fallida',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          messageText: Text(
            e.toString(),
            style: const TextStyle(color: Colors.white),
          ));
    }
  }

  void login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar("About Login", 'Login Message',
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            'Login Failed',
            style: TextStyle(color: Colors.white),
          ),
          messageText: Text(
            e.toString(),
            style: const TextStyle(
              color: Colors.white,
            ),
          ));
    }
  }

  void signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await auth.signInWithCredential(credential).then((result) async {
        UserModel _newUser = UserModel(
          uid: result.user!.uid,
          email: result.user!.email!,
          name: result.user!.displayName!,
          photoUrl: result.user!.photoURL!,
        );
        _createUserFirestore(_newUser, result.user!);
      });
    } catch (e) {
      Get.snackbar("About Google", 'Login Message',
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            'Login Google Failed',
            style: TextStyle(color: Colors.white),
          ),
          messageText: Text(
            e.toString(),
            style: const TextStyle(
              color: Colors.white,
            ),
          ));
    }
  }

  void signInWithTwitter() async {
    try {
      final twitterLogin = TwitterLogin(
        apiKey: 'cHIlrdOQlnaPDMy51eGbU9ocu',
        apiSecretKey: 'VSPvvec4XDR5SZvTo0u1uicPYVPvbG8ylJCF8JQsf7ytb7zkVd',
        redirectURI: 'https://needs-5a5d3.firebaseapp.com/__/auth/handler',
      );

      final authResult = await twitterLogin.login();
      final twitterAuthCredential = TwitterAuthProvider.credential(
        accessToken: authResult.authToken!,
        secret: authResult.authTokenSecret!,
      );
      await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
    } catch (e) {
      Get.snackbar("About Twitter", 'Login Message',
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            'Login Twitter Failed',
            style: TextStyle(color: Colors.white),
          ),
          messageText: Text(
            e.toString(),
            style: const TextStyle(
              color: Colors.white,
            ),
          ));
    }
  }

  void logOut() async {
    await auth.signOut();
    await _googleSignIn.signOut();
  }

  Future currentUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    return currentUser;
  }
}
