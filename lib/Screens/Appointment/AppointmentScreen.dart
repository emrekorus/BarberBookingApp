import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:my_barber/Utils/size_config.dart';

class AppointmentScreen extends StatefulWidget {
  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
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
    );
  }
}
