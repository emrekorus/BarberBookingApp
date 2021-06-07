import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_barber/Utils/size_config.dart';

class FavouriteBarberItem extends StatefulWidget {
  @override
  _FavouriteBarberItemState createState() => _FavouriteBarberItemState();
}

class _FavouriteBarberItemState extends State<FavouriteBarberItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[300],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2 * SizeConfig.heightMultiplier),
      ),
      clipBehavior: Clip.antiAlias,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: <Widget>[
                  Container(
                      padding:
                          EdgeInsets.only(left: 1 * SizeConfig.widthMultiplier),
                      height: MediaQuery.of(context).size.height * 0.20,
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: AssetImage('assets/images/1.jpg'),
                          fit: BoxFit.cover,
                        ),
                      )),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.20,
                    width: MediaQuery.of(context).size.width * 0.85,
                    padding: EdgeInsets.symmetric(
                        vertical: 1 * SizeConfig.heightMultiplier,
                        horizontal: 3 * SizeConfig.widthMultiplier),
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(58, 66, 86, .4)),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(
                                    0.2 * SizeConfig.heightMultiplier),
                                decoration: new BoxDecoration(
                                    border: new Border.all(color: Colors.white),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        1.5 * SizeConfig.heightMultiplier)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                    new Text(
                                      " 4.5",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("(100+)",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 1.7 *
                                                SizeConfig.textMultiplier))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.bookmark_border,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8, 4, 8, 0),
            child: Row(
              children: [
                Text(
                  "Kadir Alkan Erkek Kuaförü",
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8, 4, 8, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.map,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    Text(
                      " Ayvalı Mahallesi. Keçiören",
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 1.7 * SizeConfig.textMultiplier),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    Text(
                      "300m",
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 1.7 * SizeConfig.textMultiplier),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
