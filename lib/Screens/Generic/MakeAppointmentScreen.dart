import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:my_barber/Models/Barber.dart';
import 'package:my_barber/Models/Service.dart';
import 'package:my_barber/Models/Users.dart';
import 'package:my_barber/Screens/Generic/ConfirmAppointmentScreen.dart';
import 'package:my_barber/Screens/Generic/ReviewItem.dart';
import 'package:my_barber/Utils/size_config.dart';

import 'SystemUI.dart';

class MakeAppointmentScreen extends StatefulWidget {
  Barber barber;
  Service service;
  Users user;
  MakeAppointmentScreen(this.barber, this.service, this.user);

  @override
  _MakeAppointmentScreenState createState() => _MakeAppointmentScreenState();
}

class _MakeAppointmentScreenState extends State<MakeAppointmentScreen> {
  DateTime selectedDate = DateTime.now();
  List<String> times = [
    "10:00 - 11:00",
    "11:00 - 12:00",
    "12:00 - 13:00",
    "13:00 - 14:00",
    "14:00 - 15:00",
    "15:00 - 16:00",
    "16:00 - 17:00",
    "17:00 - 18:00",
    "18:00 - 19:00",
  ];

  String selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Make Appointment"),
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
              Container(
                padding: EdgeInsets.all(1 * SizeConfig.heightMultiplier),
                width: 100 * SizeConfig.widthMultiplier,
                color: Theme.of(context).primaryColorDark,
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 12 * SizeConfig.imageSizeMultiplier,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  DateFormat.MMMM().format(selectedDate),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      fontSize:
                                          1.7 * SizeConfig.textMultiplier),
                                ),
                                Text(selectedDate.day.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            2.5 * SizeConfig.textMultiplier)),
                                Text(DateFormat.EEEE().format(selectedDate),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        fontSize:
                                            1.7 * SizeConfig.textMultiplier))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime.now(),
                            maxTime: DateTime.now().add(Duration(days: 6)),
                            onConfirm: (date) {
                          setState(() {
                            selectedDate = date;
                          });
                        });
                      },
                      icon: Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.white,
                        size: 6 * SizeConfig.imageSizeMultiplier,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 55 * SizeConfig.heightMultiplier,
                child: new Card(
                  elevation: 2 * SizeConfig.heightMultiplier,
                  child: ListView.builder(
                      itemCount: times.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (selectedTime == times[index]) {
                                selectedTime = null;
                              } else {
                                selectedTime = times[index];
                              }
                            });
                          },
                          child: Card(
                            elevation: 1 * SizeConfig.heightMultiplier,
                            color: Colors.grey[100],
                            margin: EdgeInsets.all(4),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ClipOval(
                                        child: Material(
                                          color: Colors.grey[300],
                                          // Button color
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.fiber_smart_record,
                                              size: 4 *
                                                  SizeConfig
                                                      .imageSizeMultiplier,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(8, 4, 8, 0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                times[index] + " Available",
                                                overflow: TextOverflow.ellipsis,
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
                                      selectedTime == times[index]
                                          ? Icon(Icons.check)
                                          : SizedBox()
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        );
                      }),
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
                    selectedTime != null
                        ? SystemUI().cancelButton(() {
                             Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ConfirmAppointmentScreen(widget.barber,widget.service, selectedDate, selectedTime, widget.user),
                          ));
                          }, text: "Next")
                        : SizedBox(),
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
