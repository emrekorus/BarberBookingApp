import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_barber/Utils/size_config.dart';

class ProfileScreen extends StatefulWidget {
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
  String name = "Emre baba";

  @override
  Widget build(BuildContext context) {
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
                        color: Theme.of(context).primaryColorDark),
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
                        child: Image.asset(
                          'assets/images/emre.jpg',
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
                      child: Container(
                        height: 40,
                        width: 40,
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                name = "Mehmet Ali BABA";
                              });
                            },
                            child: Icon(
                              Icons.add_a_photo,
                              color: Colors.white,
                            )),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorDark,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      )),
                ]),
              ),
            ],
          ),
        ),
        Text(name,
            style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("emre.korus@gmail.com"),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30, top: 30),
          child: Expanded(
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
                Padding(
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
                Padding(
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
                Padding(
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
              ],
            ),
          )),
        )
      ],
    );
  }
}
