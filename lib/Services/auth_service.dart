import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_barber/Models/Users.dart';
import 'dart:io';

import 'package:my_barber/Screens/Home/HomeScreen.dart';
import 'package:my_barber/Screens/Login/LoginScreen.dart';
import 'package:my_barber/Utils/app_localizations.dart';

class AuthService {
  //Handles Auth
  handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return HomeScreen(0);
        } else {
          return LoginScreen();
        }
      },
    );
  }

  void signInWithEmail(String email, String password, BuildContext context,
      GlobalKey<ScaffoldState> scaffoldKey) async {
    // marked async
    FirebaseUser user;
    try {
      AuthResult result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      user = result.user;
    } catch (e) {
      final snackBar = SnackBar(
          content: Text(AppLocalizations.of(context)
              .translate('username_or_password_wrong')));
      scaffoldKey.currentState.showSnackBar(snackBar);
      print(e.toString());
    } finally {
      if (user != null) {
        // sign in successful!
        // ex: bring the user to the home page
        /*Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (Route<dynamic> route) => false);*/
      } else {
        // sign in unsuccessful
        // ex: prompt the user to try again
        final snackBar = SnackBar(
            content: Text(
                AppLocalizations.of(context).translate('error_signing_in')));
        scaffoldKey.currentState.showSnackBar(snackBar);
        print(
            "Auth Service - signInWithEmail():There is an error while signing in");
      }
    }
  }

  //Sign out
  signOut(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (Route<dynamic> route) => false);
  }

  // Reset Password
  Future<void> sendPasswordResetEmail(String email, BuildContext context,
      GlobalKey<ScaffoldState> scaffoldKey) async {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
      Navigator.pop(context, true);
    }).catchError((onError) {
      final snackBar = SnackBar(
          content: Text(
              AppLocalizations.of(context).translate('something_went_wrong') +
                  AppLocalizations.of(context).translate('try_again_later')));
      scaffoldKey.currentState.showSnackBar(snackBar);
    });
  }

  //Delete User
  deleteUser() async {
    FirebaseUser user;
    try {
      user = await FirebaseAuth.instance.currentUser();
      user.delete();
    } catch (e) {
      print(
          "Auth Service - deleteUser(): There is an error while deleting user");
    }
  }

  //Sign in
  signIn(AuthCredential authCredential, BuildContext context) async {
    try {
      AuthResult result =
          await FirebaseAuth.instance.signInWithCredential(authCredential);
      FirebaseUser user = result.user;

      if (user != null) {
        /*
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UserDetailRegisterScreen(
                      user.phoneNumber,
                    )));*/
      }
    } catch (e) {
      print("Sign in Error: $e");
    }
  }

  //Sign in with sms code
  signInWithOTP(smsCode, verificationId, BuildContext context) {
    AuthCredential authCredential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: smsCode);

    signIn(authCredential, context);
  }

  Future<Users> getCurrentUser() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    Users userModel;
    await FirebaseDatabase.instance
        .reference()
        .child("user_list")
        .child(user.uid)
        .once()
        .then((DataSnapshot snapshot) async {
      if (snapshot.value != null) {
        userModel = Users.fromSnapshot(snapshot);
      } else {
        print(
            "Auth Service - getCurrentUser(): User cannot found in Firebase Database");
        return userModel;
      }
    });
    print("Auth Service - getCurrentUser(): " + userModel.toString());
    return userModel;
  }

  Future<String> uploadImageToFirebase(
    File image,
    String user_id,
  ) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('user_list/$user_id/$fileName');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    await taskSnapshot.ref.getDownloadURL().then(
      (value) async {
        print("Done: $value");
        var url =  await updateProfileImage(value, user_id);
        print("url:" + url  + "   \nvalue: " + value);
        return url;
      },
    ).catchError((onError) {
      print("Done: $onError");
    });
  }

  Future<String> updateProfileImage(String image_url, String user_id) async {
    await FirebaseDatabase.instance
        .reference()
        .child("user_list")
        .child(user_id)
        .child("profile_image")
        .set(image_url)
        .then((v) async {});

    return image_url;
  }
}
