import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_barber/Models/HelperModels/ReservationHelper.dart';
import 'package:my_barber/Models/Reservation.dart';
import 'package:my_barber/Models/Users.dart';
import 'package:my_barber/Screens/Generic/LoadingScreen.dart';
import 'package:my_barber/Screens/Generic/ReservationItem.dart';
import 'package:my_barber/Services/DatabaseHelper.dart';
import 'package:my_barber/Utils/size_config.dart';

class AppointmentScreen extends StatefulWidget {
  Users user;

  AppointmentScreen(this.user);

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  bool isLoading = true;
  List<ReservationHelper> _allReservations = [];
  List<ReservationHelper> _onGoingReservations = [];
  List<ReservationHelper> _historyReservations = [];

  void getAppointments() async {
    setState(() {
      isLoading = true;
    });
    var reservations =
        await DatabaseHelper().getReservations(widget.user.user_id);

    var now = DateTime.now();
    for (int i = 0; i < reservations.length; i++) {
      DateTime tempDate = DateFormat("dd/MM/yyyy HH").parse(
          reservations[i].date + " " + reservations[i].time.substring(8, 10));
      if (tempDate.isBefore(now)) {
        _historyReservations.add(reservations[i]);
      } else {
        _onGoingReservations.add(reservations[i]);
      }
    }
    if (mounted) {
      setState(() {
        // _allReservations = reservations;
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? LoadingScreen()
        : new DefaultTabController(
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
                                  "Ongoing",
                                  style: TextStyle(
                                      fontSize: 2 * SizeConfig.textMultiplier),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text("History",
                                    style: TextStyle(
                                        fontSize:
                                            2 * SizeConfig.textMultiplier)),
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
                  new Column(children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                          itemCount: _onGoingReservations.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ReservationItem(_onGoingReservations[index],
                                false, widget.user);
                          }),
                    )
                  ]),
                  new Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView.builder(
                            itemCount: _historyReservations.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ReservationItem(
                                  _historyReservations[index],
                                  true,
                                  widget.user);
                            }),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
  }
}
