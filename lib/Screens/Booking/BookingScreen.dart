import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:my_barber/Utils/size_config.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int step = 1;
  String selectedCity = "";

  displayCityList() {
    List<String> cities = ["Ankara", "İstanbul", "İzmir"];

    return ListView.builder(
        itemCount: cities.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCity = cities[index];
              });
            },
            child: Card(
                child: ListTile(
              leading: Icon(Icons.home_work),
              trailing:
                  (selectedCity == cities[index]) ? Icon(Icons.check) : null,
              title: Text(cities[index]),
            )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NumberStepper(
          activeStep: step - 1,
          direction: Axis.horizontal,
          enableNextPreviousButtons: false,
          enableStepTapping: false,
          numbers: [1, 2, 3, 4, 5],
          stepColor: Theme.of(context).primaryColor,
          activeStepColor: Theme.of(context).primaryColorDark,
          numberStyle: TextStyle(color: Colors.white),
          lineColor: Colors.black,
        ),
        Expanded(child: step == 1 ? displayCityList() : SizedBox()),
        Expanded(
            child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: ElevatedButton(
                  onPressed: step == 1
                      ? null
                      : () {
                          setState(() {
                            step--;
                          });
                        },
                  child: Text("Previous"),
                )),
                SizedBox(
                  width: 10 * SizeConfig.widthMultiplier,
                ),
                Expanded(
                    child: ElevatedButton(
                  onPressed: selectedCity == ""
                      ? null
                      : step == 5
                          ? null
                          : () {
                              setState(() {
                                step++;
                              });
                            },
                  child: Text('Next'),
                ))
              ],
            ),
          ),
        ))
      ],
    );
  }
}
