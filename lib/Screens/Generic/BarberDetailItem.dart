import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_barber/Screens/Generic/ReviewItem.dart';
import 'package:my_barber/Utils/size_config.dart';

class BarberDetailItem extends StatefulWidget {
  @override
  _BarberDetailItemState createState() => _BarberDetailItemState();
}

class _BarberDetailItemState extends State<BarberDetailItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Barber Detail"),
      ),
      body: ListView(
        children: [
          Container(
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: <Widget>[
                      Container(
                          padding:
                              EdgeInsets.only(left: 1 * SizeConfig.widthMultiplier),
                          height: MediaQuery.of(context).size.height * 0.30,
                          width: MediaQuery.of(context).size.width,
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                              image: AssetImage('assets/images/1.jpg'),
                              fit: BoxFit.cover,
                            ),
                          )),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.30,
                        width: MediaQuery.of(context).size.width,
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
                padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
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
                padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
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
              Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.sort,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    SizedBox(
                      width: 2 * SizeConfig.widthMultiplier,
                    ),
                    Flexible(
                      child: Text(
                        "Gold Berber / Ankara Berber / Ankara Kuaför / Saç Tasarım / Cilt Bakım / Model Kesim / Klasik Kesim / Tarz Kesim / Asimetrik Kesimler / Ankara nın En İyi Berberi / Etimesgut / Bağlıca",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 1.7 * SizeConfig.textMultiplier),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 30*SizeConfig.heightMultiplier,
                child: DefaultTabController(
                  length: 2,
                  child: new Scaffold(
                    appBar: new PreferredSize(
                      preferredSize: Size.fromHeight(9 * SizeConfig.heightMultiplier),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Card(
                          elevation: 2 * SizeConfig.heightMultiplier,
                          color: Theme.of(context).primaryColor,
                          child: new SafeArea(
                            child: Column(
                              children: <Widget>[
                                new Expanded(child: new Container()),
                                new TabBar(
                                  indicatorColor: Colors.white,
                                  tabs: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: new Text(
                                        "Future",
                                        style: TextStyle(
                                            fontSize: 2 * SizeConfig.textMultiplier),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: new Text("History",
                                          style: TextStyle(
                                              fontSize: 2 * SizeConfig.textMultiplier)),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    body: new TabBarView(
                      children: <Widget>[
                        new Column(
                          children: <Widget>[new Text("Future Page")],
                        ),
                        new Column(
                          children: <Widget>[new Text("History Page")],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 2 * SizeConfig.heightMultiplier,
                child: Column(
                  children: [
                    SizedBox(
                      height: 1 * SizeConfig.heightMultiplier,
                    ),
                    ReviewItem(),
                    Divider(
                      height: 3 * SizeConfig.heightMultiplier,
                      color: Colors.grey,
                      indent: 3 * SizeConfig.widthMultiplier,
                      endIndent: 3 * SizeConfig.widthMultiplier,
                    ),
                    ReviewItem(),
                    SizedBox(
                      height: 1 * SizeConfig.heightMultiplier,
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
