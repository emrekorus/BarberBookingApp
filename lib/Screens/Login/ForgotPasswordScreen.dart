import 'package:flutter/material.dart';
import 'package:my_barber/Services/auth_service.dart';
import 'package:my_barber/Utils/app_localizations.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  String _email;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Şifre Sıfırlama"),
        ),
        body: ListView(children: <Widget>[
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
              Widget>[
            SizedBox(
              height: 8.0,
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Image.asset('assets/images/logo.png'),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                      padding:
                      EdgeInsets.only(top: 8.0, left: 20.0, right: 20.0),
                      child: Column(
                        children: <Widget>[
                          Text("Email Adresinizi Giriniz.", style: Theme.of(context).textTheme.button,),
                          TextFormField(
                            validator: (input) {
                              if (input.isEmpty) {
                                return AppLocalizations.of(context)
                                    .translate('type_email');
                              }
                              return null;
                            },
                            onSaved: (input) {
                              _email = input;
                            } ,
                            decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)
                                    .translate('email'),
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .primaryColorDark))),
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 20.0),

                          GestureDetector(
                            onTap: resetPassword,
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.06,
                              child: Material(
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.height * 0.03),
                                shadowColor: Theme.of(context).primaryColor,
                                color: Theme.of(context).primaryColorDark,
                                elevation: 7.0,
                                child: Center(
                                  child: Text("Sıfırla",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                        ],
                      )),
                  SizedBox(height: 15.0),
                ],
              ),
            ),
          ])
        ]));
  }


  Future<void> resetPassword() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_email);
        if(emailValid){
          await AuthService().sendPasswordResetEmail(_email,context,_scaffoldKey);
        }
        else{
          final snackBar = SnackBar(content: Text("Geçerli Bir Mail Adresi Giriniz."));
          _scaffoldKey.currentState.showSnackBar(snackBar);
        }


      } catch (e) {
        print(e);
        final snackBar = SnackBar(content: Text(AppLocalizations.of(context).translate('something_went_wrong') + AppLocalizations.of(context).translate('try_again_later')));
        _scaffoldKey.currentState.showSnackBar(snackBar);
      }
    }
  }
}
