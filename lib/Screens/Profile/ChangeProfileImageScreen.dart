import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_barber/Screens/Generic/LoadingScreen.dart';
import 'package:my_barber/Services/auth_service.dart';
import 'package:my_barber/Utils/app_localizations.dart';
import 'package:my_barber/Utils/size_config.dart';

class ChangeProfileImageScreen extends StatefulWidget {
  String img_url;
  String user_id;

  ChangeProfileImageScreen(this.img_url, this.user_id);

  @override
  _ChangeProfileImageScreenState createState() =>
      _ChangeProfileImageScreenState();
}

class _ChangeProfileImageScreenState extends State<ChangeProfileImageScreen> {
  File _image;
  var picker = ImagePicker();
  bool isLoading = false;
  bool isUploading = false;

  _imgFromCamera() async {
    PickedFile image =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _image = File(image.path);
    });
  }

  _imgFromGallery() async {
    PickedFile image =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _image = File(image.path);
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: SizeConfig.heightMultiplier * 30,
            decoration: new BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(SizeConfig.widthMultiplier * 100,
                      SizeConfig.heightMultiplier * 15)),
              gradient: LinearGradient(colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColorDark
              ], stops: [
                0,
                1
              ], begin: Alignment.topCenter),
            ),
          ),
          ListView(
            children: [
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(SizeConfig.heightMultiplier * 2),
                  child: Column(
                    children: <Widget>[
                      Container(
                          height: SizeConfig.heightMultiplier * 10,
                          margin: EdgeInsets.only(
                              bottom: SizeConfig.heightMultiplier * 2),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            AppLocalizations.of(context)
                                                .translate('profile_image'),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize:
                                                    SizeConfig.textMultiplier *
                                                        3),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: SizeConfig.widthMultiplier * 2,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          _showPicker(context);
                                        },
                                        child: CircleAvatar(
                                          radius:
                                              SizeConfig.widthMultiplier * 6,
                                          child: Icon(Icons.edit),
                                        ),
                                      ),
                                      SizedBox(
                                        width: SizeConfig.widthMultiplier * 2,
                                      ),
                                      GestureDetector(
                                        onTap: (_image != null)
                                            ? () async {
                                                setState(() {
                                                  isUploading = true;
                                                });
                                                var url = await AuthService()
                                                    .uploadImageToFirebase(
                                                        _image, widget.user_id);
                                                print(url);
                                                setState(() {
                                                  isUploading = false;
                                                });
                                                Navigator.pop(context, url);
                                              }
                                            : null,
                                        child: CircleAvatar(
                                          radius:
                                              SizeConfig.widthMultiplier * 6,
                                          child: Icon(
                                            Icons.save,
                                            color: (_image != null)
                                                ? Colors.white
                                                : Colors.white70,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: SizeConfig.widthMultiplier * 2,
                                      ),
                                    ])
                              ])),
                      isLoading
                          ? LoadingScreen()
                          : isUploading
                              ? Column(
                                  children: [
                                    Center(
                                        child: SpinKitFadingCircle(
                                      color: Theme.of(context).primaryColorDark,
                                    )),
                                    Center(
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .translate('uploading'),
                                        style: TextStyle(
                                          fontSize:
                                              SizeConfig.textMultiplier * 3,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : (_image == null)
                                  ? (widget.img_url != null)
                                      ? new Image.network(
                                          widget.img_url,
                                          fit: BoxFit.cover,
                                          alignment: Alignment.center,
                                        )
                                      : Image.asset(
                                          'assets/images/profile_avatar.png',
                                          fit: BoxFit.cover,
                                          alignment: Alignment.center,
                                        )
                                  : Image.file(
                                      _image,
                                      fit: BoxFit.cover,
                                      alignment: Alignment.center,
                                    ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
