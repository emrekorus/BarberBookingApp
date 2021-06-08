import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_barber/Models/Barber.dart';
import 'package:my_barber/Models/Service.dart';
import 'package:my_barber/Models/Users.dart';
import 'package:my_barber/Screens/Generic/MakeAppointmentScreen.dart';
import 'package:my_barber/Screens/Generic/ReviewItem.dart';
import 'package:my_barber/Utils/size_config.dart';

import 'SystemUI.dart';

class BarberDetailItem extends StatefulWidget {
  Barber barber;
  Users user;

  BarberDetailItem(this.barber, this.user);

  @override
  _BarberDetailItemState createState() => _BarberDetailItemState();
}

class _BarberDetailItemState extends State<BarberDetailItem> {
  int _radioValue = 0;
  List<Service> services = [];

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
    });
  }

  @override
  void initState() {
    super.initState();
    List<String> names = [
      "Hair Style",
      "Change Hair Color",
      "Hair Cutting",
      "Skin Care"
    ];
    for (int i = 0; i < 4; i++) {
      Service service = Service(i, names[i], (Random().nextInt(7) + 6) * 5,
          (Random().nextInt(7) + 8) * 5, "assets/images/${(i + 1)}.jpg");
      services.add(service);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.barber.name),
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
                          padding: EdgeInsets.only(
                              left: 1 * SizeConfig.widthMultiplier),
                          height: MediaQuery.of(context).size.height * 0.30,
                          width: MediaQuery.of(context).size.width,
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                              image: NetworkImage(widget.barber.image),
                              fit: BoxFit.cover,
                            ),
                          )),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.30,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(
                            vertical: 1 * SizeConfig.heightMultiplier,
                            horizontal: 3 * SizeConfig.widthMultiplier),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(58, 66, 86, .4)),
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
                                        border:
                                            new Border.all(color: Colors.white),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                            1.5 * SizeConfig.heightMultiplier)),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        ),
                                        new Text(
                                          " ${widget.barber.stars}",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColorDark,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            "(${widget.barber.reviews.length}+)",
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
                padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Row(
                  children: [
                    Text(
                      widget.barber.name,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.map,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    Flexible(
                      child: Text(
                        " ${widget.barber.address}",
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 1.7 * SizeConfig.textMultiplier),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
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
                        widget.barber.about,
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
                height: 70 * SizeConfig.heightMultiplier,
                child: DefaultTabController(
                  length: 3,
                  child: new Scaffold(
                    appBar: new PreferredSize(
                      preferredSize:
                          Size.fromHeight(12 * SizeConfig.heightMultiplier),
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
                                        "Reviews",
                                        style: TextStyle(
                                            fontSize:
                                                2 * SizeConfig.textMultiplier),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: new Text(
                                        "Hair Stylists",
                                        style: TextStyle(
                                            fontSize:
                                                2 * SizeConfig.textMultiplier),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: new Text("Services",
                                            style: TextStyle(
                                                fontSize: 2 *
                                                    SizeConfig.textMultiplier)))
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
                        new Card(
                          elevation: 2 * SizeConfig.heightMultiplier,
                          child: ListView.builder(
                              itemCount: widget.barber.reviews.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ReviewItem(widget.barber.reviews[index]);
                              }),
                        ),
                        new Card(
                          elevation: 2 * SizeConfig.heightMultiplier,
                          child: ListView.builder(
                              itemCount: widget.barber.personals.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  elevation: 1 * SizeConfig.heightMultiplier,
                                  color: Colors.grey[100],
                                  margin: EdgeInsets.all(4),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            ClipOval(
                                              child: Material(
                                                color: Colors.grey[300],
                                                // Button color
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.person,
                                                    size: 4 *
                                                        SizeConfig
                                                            .imageSizeMultiplier,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    8, 4, 8, 0),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      widget
                                                          .barber
                                                          .personals[index]
                                                          .barber_name,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontSize: 1.7 *
                                                              SizeConfig
                                                                  .textMultiplier),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]),
                                  ),
                                );
                                ;
                              }),
                        ),
                        new Card(
                            elevation: 2 * SizeConfig.heightMultiplier,
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 1 * SizeConfig.heightMultiplier,
                                    horizontal: 3 * SizeConfig.widthMultiplier),
                                child: Column(
                                  children: [
                                    Expanded(child: servicesUI()),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Divider(
                                          height:
                                              2 * SizeConfig.heightMultiplier,
                                        ),
                                        SystemUI().cancelButton(() {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    MakeAppointmentScreen(
                                                        widget.barber,
                                                        services[_radioValue], widget.user),
                                              ));
                                        }, text: "Book Appointment"),
                                        Divider(
                                          height:
                                              1 * SizeConfig.heightMultiplier,
                                          color: Colors.transparent,
                                        ),
                                      ],
                                    ),
                                  ],
                                ))),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget radioUI(Service service) {
    bool isActive = _radioValue == service.id;
    Color activeColor = Colors.black;
    if (isActive) {
      activeColor = Colors.red;
    }

    return GestureDetector(
      onTap: () {
        _handleRadioValueChange(service.id);
      },
      child: Card(
        color: Colors.grey[100],
        elevation: 1 * SizeConfig.heightMultiplier,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 0, vertical: 1 * SizeConfig.heightMultiplier),
          child: Row(
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(2 * SizeConfig.heightMultiplier),
                child: Image.asset(
                  service.image,
                  height: 15 * SizeConfig.widthMultiplier,
                  width: 15 * SizeConfig.widthMultiplier,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 4, 8, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            service.name,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 2 * SizeConfig.textMultiplier),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 4, 8, 0),
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              "${service.min} Min",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 1.7 * SizeConfig.textMultiplier),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(
                            width: 4 * SizeConfig.widthMultiplier,
                          ),
                          Text(
                            "${service.price} ₺",
                            style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                                fontSize: 2 * SizeConfig.textMultiplier),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Radio(
                value: service.id,
                groupValue: _radioValue,
                activeColor: activeColor,
                onChanged: _handleRadioValueChange,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget servicesUI() {
    return ListView.builder(
        itemCount: services.length,
        itemBuilder: (BuildContext context, int index) {
          return radioUI(services[index]);
        });

/*
    Column(
    children: [
    radioUI(0, "assets/images/1.jpg", "Hair Style", mins[0], prices[0]),
    Divider(
    height: 0 * SizeConfig.heightMultiplier,
    color: Colors.black45,
    ),
    radioUI(
    1, "assets/images/2.jpg", "Change Hair Color", mins[1], prices[1]),
    Divider(
    height: 0 * SizeConfig.heightMultiplier,
    color: Colors.black45,
    ),
    radioUI(2, "assets/images/3.jpg", "Hair Cutting", mins[2], prices[2]),
    Divider(
    height: 0 * SizeConfig.heightMultiplier,
    color: Colors.black45,
    ),
    radioUI(3, "assets/images/4.jpg", "Skin Care", mins[3], prices[3]),
    ]
    ,
    );*/
  }
}
