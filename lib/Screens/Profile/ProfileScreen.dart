import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_barber/Models/Users.dart';
import 'package:my_barber/Screens/Generic/SystemUI.dart';
import 'package:my_barber/Services/auth_service.dart';
import 'package:my_barber/Utils/size_config.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'ChangeProfileImageScreen.dart';

class ProfileScreen extends StatefulWidget {
  Users user;

  ProfileScreen(this.user);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - 150);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  final panelController = PanelController();
  bool isHelpBtnClicked = false;
  bool isEditBtnClicked = false;
  Users _user;

  void getUser() async {
    var user = await AuthService().getCurrentUser();
    setState(() {
      _user = user;
      widget.user.profile_image = _user.profile_image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(2 * SizeConfig.heightMultiplier),
            topLeft: Radius.circular(2 * SizeConfig.heightMultiplier)),
        controller: panelController,
        minHeight: 0,
        maxHeight: 45 * SizeConfig.heightMultiplier,
        panelBuilder: (scrollController) => buildSlidingPanel(
            scrollController: scrollController,
            panelController: panelController),
        body: profileScreenBody());
  }

  @override
  Widget profileScreenBody() {
    return Column(
      children: <Widget>[
        Container(
          child: Stack(
            children: <Widget>[
              Stack(
                children: [
                  ClipPath(
                    clipper: MyCustomClipper(),
                    child: Container(
                        height: 25 * SizeConfig.heightMultiplier,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                              Theme.of(context).primaryColorDark,
                              Color.fromRGBO(0, 41, 102, 1)
                            ]))),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.center,
                child: Stack(children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.only(top: SizeConfig.heightMultiplier * 5),
                    child: CircleAvatar(
                      radius: 70,
                      child: ClipOval(
                        child: Image.network(
                          widget.user.profile_image,
                          height: 20 * SizeConfig.heightMultiplier,
                          width: 20 * SizeConfig.heightMultiplier,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 1,
                      right: 1,
                      child: GestureDetector(
                        onTap: () async {
                          var url = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ChangeProfileImageScreen(
                                          widget.user.profile_image,
                                          widget.user.user_id)));

                          setState(() {
                            getUser();
                          });
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          child: Icon(
                            Icons.add_a_photo,
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorDark,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                      )),
                ]),
              ),
            ],
          ),
        ),
        Text(widget.user.name + " " + widget.user.surname,
            style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(widget.user.email),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30, top: 30),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Theme.of(context).primaryColorDark,
                      Color.fromRGBO(0, 41, 102, 1)
                    ])),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    if (panelController.isPanelOpen) {
                      setState(() {
                        isEditBtnClicked = false;
                      });

                      panelController.close();
                    } else {
                      setState(() {
                        isEditBtnClicked = true;
                      });
                      panelController.open();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 25, 20, 10),
                    child: Container(
                      height: 8 * SizeConfig.heightMultiplier,
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border: Border.all(width: 1.0, color: Colors.white)),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (panelController.isPanelOpen) {
                      setState(() {
                        isHelpBtnClicked = false;
                      });
                      panelController.close();
                    } else {
                      setState(() {
                        isHelpBtnClicked = true;
                      });
                      panelController.open();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                    child: Container(
                      height: 8 * SizeConfig.heightMultiplier,
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Help',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border: Border.all(width: 1.0, color: Colors.white)),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    AuthService().signOut(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                    child: Container(
                      height: 8 * SizeConfig.heightMultiplier,
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Log Out',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border: Border.all(width: 1.0, color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget sortingUIHelp() {

    isHelpBtnClicked = false;


    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(45 * SizeConfig.heightMultiplier),
              color: Colors.grey.withOpacity(0.5)),
          width: 15 * SizeConfig.widthMultiplier,
          height: 4,
        ),
        SizedBox(
          height: 1 * SizeConfig.heightMultiplier,
        ),
        Padding(
          padding: EdgeInsets.all(1 * SizeConfig.heightMultiplier),
          child: Row(
            children: [
              Text(
                "Help",
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
        Divider(
          height: 0 * SizeConfig.heightMultiplier,
          color: Colors.black45,
        ),
        Padding(
          padding: const EdgeInsets.only(top:30),
          child: Text("16050111041 - Emre KÖRÜS"),
        ),
        Padding(
          padding: const EdgeInsets.only(top:10),
          child: Text("16050111044 - Mehmet Ali CABİOĞLU"),
        ),
        Container(
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Stack(children: <Widget>[
                  Padding(
                    padding:
                    EdgeInsets.only(top: SizeConfig.heightMultiplier * 4),
                    child: Container(
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 13 * SizeConfig.heightMultiplier
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget sortingUIEdit() {

      isEditBtnClicked = false;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(5 * SizeConfig.heightMultiplier),
              color: Colors.grey.withOpacity(0.5)),
          width: 15 * SizeConfig.widthMultiplier,
          height: 4,
        ),
        SizedBox(
          height: 1 * SizeConfig.heightMultiplier,
        ),
        Padding(
          padding: EdgeInsets.all(1 * SizeConfig.heightMultiplier),
          child: Row(
            children: [
              Text(
                "Edit",
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top:50.0),
          child: Container(
            child: Image.asset(
                'assets/images/editProfile.png',
                height: 18 * SizeConfig.heightMultiplier
            ),
          ),
        )
      ],
    );
  }

  Widget buildSlidingPanel(
      {@required ScrollController scrollController,
      @required PanelController panelController}) {
    return Padding(
        padding: EdgeInsets.symmetric(
            vertical: 1 * SizeConfig.heightMultiplier,
            horizontal: 3 * SizeConfig.widthMultiplier),
        child: Column(
          children: [
            isHelpBtnClicked ? sortingUIHelp() : isEditBtnClicked? sortingUIEdit() : Container(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Divider(
                    height: 2 * SizeConfig.heightMultiplier,
                  ),
                  SystemUI().cancelButton(() {
                    panelController.close();
                  }),
                  Divider(
                    height: 1 * SizeConfig.heightMultiplier,
                    color: Colors.transparent,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
