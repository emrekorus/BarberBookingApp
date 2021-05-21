import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_barber/Services/auth_service.dart';
import 'package:my_barber/Utils/app_localizations.dart';
import 'package:my_barber/Utils/size_config.dart';
import 'ForgotPasswordScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  DatabaseReference dbReference = FirebaseDatabase.instance.reference();
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: ListView(
          children: [
            Container(
                padding: EdgeInsets.all(3 * SizeConfig.heightMultiplier),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8 * SizeConfig.heightMultiplier,
                      ),
                      Container(
                        height: 20 * SizeConfig.heightMultiplier,
                        width: 20 * SizeConfig.heightMultiplier,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/logo.png'))),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context).translate('welcome'),
                              style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                                fontSize: 4 * SizeConfig.textMultiplier,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context)
                                  .translate('log_in_your_account'),
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 3 * SizeConfig.textMultiplier,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 1 * SizeConfig.heightMultiplier,
                            ),
                            TextFormField(
                              validator: (input) {
                                if (input.isEmpty) {
                                  return AppLocalizations.of(context)
                                      .translate('type_email');
                                }
                                return null;
                              },
                              onSaved: (input) {
                                _email = input.trim();
                              },
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)
                                    .translate('email'),
                              ),
                            ),
                            TextFormField(
                              validator: (input) {
                                if (input.length < 6) {
                                  return AppLocalizations.of(context)
                                      .translate('provide_password');
                                }
                                return null;
                              },
                              onSaved: (input) => _password = input,
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)
                                    .translate('password'),
                              ),
                              obscureText: true,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    bool result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ForgotPasswordScreen()));
                                    if (result != null && result == true) {
                                      final snackBar = SnackBar(
                                          content: Text(
                                              'Şifre Sıfırlama Maili Gönderildi. Mail Adresinizi Kontrol Ediniz.'));
                                      _scaffoldKey.currentState
                                          .showSnackBar(snackBar);
                                    } else if (result != null &&
                                        result == false) {
                                      final snackBar = SnackBar(
                                          content: Text(AppLocalizations.of(
                                                      context)
                                                  .translate(
                                                      'something_went_wrong') +
                                              AppLocalizations.of(context)
                                                  .translate(
                                                      'try_again_later')));
                                      _scaffoldKey.currentState
                                          .showSnackBar(snackBar);
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('forgot_password'),
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5 * SizeConfig.heightMultiplier,
                            ),
                            InkWell(
                              onTap: login,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5 * SizeConfig.widthMultiplier),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            6 * SizeConfig.heightMultiplier)),
                                    gradient: LinearGradient(colors: [
                                      Theme.of(context).primaryColor,
                                      Theme.of(context).primaryColorDark
                                    ], stops: [
                                      0,
                                      1
                                    ], begin: Alignment.topCenter)),
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate('login'),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 3 * SizeConfig.textMultiplier,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                    ])),
          ],
        ));
  }

  Future<void> login() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      print("clicked");
      try {
        bool isEmailInUsing = false;
        print("clicked2");
        await dbReference.child("user_list").once().then((DataSnapshot snapshot) {
          print("clicked3");
          if (snapshot.value != null) {
            var DATA = snapshot.value;
            for (var individualKey in snapshot.value.keys) {
              String email_in_database = DATA[individualKey]["mail"];

              if (email_in_database == _email) {
                AuthService()
                    .signInWithEmail(_email, _password, context, _scaffoldKey);
                isEmailInUsing = true;
                break;
              }
            }

            if (isEmailInUsing == false) {
              final snackBar = SnackBar(
                  content: Text(AppLocalizations.of(context)
                      .translate('user_not_found')));
              _scaffoldKey.currentState.showSnackBar(snackBar);
            }
          } else {
            final snackBar = SnackBar(
                content: Text(AppLocalizations.of(context)
                    .translate('something_went_wrong')));
            _scaffoldKey.currentState.showSnackBar(snackBar);
          }
        });
      } catch (e) {
        print("Login Screen " + e);
        final snackBar = SnackBar(
            content: Text(
                AppLocalizations.of(context).translate('error_signing_in')));
        _scaffoldKey.currentState.showSnackBar(snackBar);
      }
    }
  }
}
