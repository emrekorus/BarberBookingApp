import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:my_barber/Models/Barber.dart';
import 'package:my_barber/Models/Reservation.dart';
import 'package:my_barber/Models/Service.dart';
import 'package:my_barber/Models/Users.dart';
import 'package:my_barber/Screens/Generic/ReviewItem.dart';
import 'package:my_barber/Screens/Home/HomeScreen.dart';
import 'package:my_barber/Services/DatabaseHelper.dart';
import 'package:my_barber/Utils/size_config.dart';

import 'SystemUI.dart';

class ConfirmAppointmentScreen extends StatefulWidget {
  Barber barber;
  Service service;
  DateTime time;
  String timeInterval;
  Users user;

  ConfirmAppointmentScreen(
      this.barber, this.service, this.time, this.timeInterval, this.user);

  @override
  _ConfirmAppointmentScreenState createState() =>
      _ConfirmAppointmentScreenState();
}

class _ConfirmAppointmentScreenState extends State<ConfirmAppointmentScreen> {
  int index = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      index = Random().nextInt(widget.barber.personals.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Confirm Appointment"),
      ),
      body: ListView(
        children: [
          Container(
            child: Column(children: [
              Card(
                color: Colors.grey[200],
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                                2 * SizeConfig.heightMultiplier),
                            child: Image.asset(
                              widget.service.image,
                              height: 20 * SizeConfig.widthMultiplier,
                              width: 20 * SizeConfig.widthMultiplier,
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
                                        widget.barber.name,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize:
                                                2 * SizeConfig.textMultiplier),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(8, 4, 8, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.service.name,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 1.7 *
                                                    SizeConfig.textMultiplier),
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
                                              "${widget.service.min} Min",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 1.7 *
                                                      SizeConfig
                                                          .textMultiplier),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          SizedBox(
                                            width:
                                                4 * SizeConfig.widthMultiplier,
                                          ),
                                          Text(
                                            "${widget.service.price} ₺",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColorDark,
                                                fontSize: 2 *
                                                    SizeConfig.textMultiplier),
                                            textAlign: TextAlign.right,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Card(
                                  elevation: 1 * SizeConfig.heightMultiplier,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical:
                                            1 * SizeConfig.heightMultiplier),
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
                                          size: 4 *
                                              SizeConfig.imageSizeMultiplier,
                                        ),
                                        new Text(
                                          " ${widget.barber.stars}",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColorDark,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 1.7 *
                                                  SizeConfig.textMultiplier),
                                        ),
                                        Text(
                                            "(${widget.barber.reviews.length}+)",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 1.5 *
                                                    SizeConfig.textMultiplier))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(3 * SizeConfig.heightMultiplier),
                child: Container(
                  height: 20 * SizeConfig.heightMultiplier,
                  width: 20 * SizeConfig.heightMultiplier,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/logo.png'))),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("BOOKING INFORMATION")],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 1 * SizeConfig.heightMultiplier,
                    horizontal: 5 * SizeConfig.widthMultiplier),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today_outlined),
                    SizedBox(
                      width: 4 * SizeConfig.widthMultiplier,
                    ),
                    Text(
                      widget.timeInterval +
                          " - ${DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(widget.time.millisecondsSinceEpoch)).toString()}",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 1.8 * SizeConfig.textMultiplier),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 1 * SizeConfig.heightMultiplier,
                    horizontal: 5 * SizeConfig.widthMultiplier),
                child: Row(
                  children: [
                    Icon(Icons.person),
                    SizedBox(
                      width: 4 * SizeConfig.widthMultiplier,
                    ),
                    Text(
                      widget.barber.personals[index].barber_name,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 1.8 * SizeConfig.textMultiplier),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 1 * SizeConfig.heightMultiplier,
                    horizontal: 5 * SizeConfig.widthMultiplier),
                child: Row(
                  children: [
                    Icon(Icons.home_work),
                    SizedBox(
                      width: 4 * SizeConfig.widthMultiplier,
                    ),
                    Text(
                      widget.barber.name,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 1.8 * SizeConfig.textMultiplier),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 1 * SizeConfig.heightMultiplier,
                    horizontal: 5 * SizeConfig.widthMultiplier),
                child: Row(
                  children: [
                    Icon(Icons.location_pin),
                    SizedBox(
                      width: 4 * SizeConfig.widthMultiplier,
                    ),
                    Flexible(
                      child: Text(
                        widget.barber.address,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 1.8 * SizeConfig.textMultiplier),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Divider(
                      height: 2 * SizeConfig.heightMultiplier,
                    ),
                    SystemUI().cancelButton(
                      () {
                        Reservation reservation = Reservation(
                            "${DateFormat('ddMMyyyy').format(DateTime.fromMillisecondsSinceEpoch(widget.time.millisecondsSinceEpoch)).toString()}@${widget.timeInterval.substring(0, 2)}",
                            widget.barber.ID,
                            "${DateFormat('ddMMyyyy').format(DateTime.fromMillisecondsSinceEpoch(widget.time.millisecondsSinceEpoch)).toString()}",
                            widget.timeInterval,
                            widget.service.name);
                        DatabaseHelper().createReservation(
                            widget.user.user_id, reservation);
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => HomeScreen(0)),
                            (Route<dynamic> route) => false);
                      },
                      text: "Confirm",
                    ),
                    Divider(
                      height: 1 * SizeConfig.heightMultiplier,
                      color: Colors.transparent,
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
