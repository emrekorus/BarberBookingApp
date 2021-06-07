import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_barber/Models/Barber.dart';
import 'package:my_barber/Models/Users.dart';
import 'package:my_barber/Screens/Generic/BarberItem.dart';
import 'package:my_barber/Screens/Generic/FavouriteBarberItem.dart';
import 'package:my_barber/Screens/Generic/LoadingScreen.dart';
import 'package:my_barber/Screens/Generic/SystemUI.dart';
import 'package:my_barber/Services/DatabaseHelper.dart';
import 'package:my_barber/Utils/app_localizations.dart';
import 'package:my_barber/Utils/size_config.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DiscoverScreen extends StatefulWidget {
  Users user;

  DiscoverScreen(this.user);

  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  bool isLoading = true;
  List<Barber> _barbers = [];

  List<int> list = [1, 2, 3, 4, 5];
  List<String> list2 = [
    "assets/images/1.jpg",
    "assets/images/2.jpg",
    "assets/images/3.jpg",
    "assets/images/4.jpg",
    "assets/images/5.jpg",
    "assets/images/6.jpg"
  ];
  int _radioValue = 0;
  final panelController = PanelController();

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
    });
  }

  getBarbers() async {
    setState(() {
      isLoading = true;
    });
    try {
      List<Barber> barbers = await DatabaseHelper().getBarbers();
      if (mounted) {
        setState(() {
          _barbers = barbers;
        });
      }
    } catch (e) {
      print("getBarbers (): Exception: $e");
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getBarbers();
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
        body: isLoading ? LoadingScreen() : discoverScreenBody());
  }

  Widget discoverScreenBody() {
    return Column(
      children: [
        Container(
            width: 100 * SizeConfig.widthMultiplier,
            decoration: BoxDecoration(color: Colors.yellowAccent[400]),
            child: Row(
              children: [
                Container(
                  width: 75 * SizeConfig.widthMultiplier,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight:
                            Radius.circular(5 * SizeConfig.heightMultiplier),
                        bottomRight:
                            Radius.circular(5 * SizeConfig.heightMultiplier)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ClipRRect(
                      child: Container(
                          padding:
                              EdgeInsets.all(2 * SizeConfig.heightMultiplier),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.home_work),
                              Container(
                                  height: 3 * SizeConfig.heightMultiplier,
                                  child: VerticalDivider(
                                    color: Colors.black,
                                  )),
                              Text("Ev"),
                              Text(
                                "Etimesgut Mahallesi...",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Icon(Icons.arrow_forward_ios),
                            ],
                          ))),
                ),
              ],
            )),
        Container(
          height: 75 * SizeConfig.heightMultiplier,
          child: ListView(
            children: [
              Container(
                  child: CarouselSlider(
                options: CarouselOptions(
                    viewportFraction: 1,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 5)),
                items: list2
                    .map((item) => Container(
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset(
                          item,
                          fit: BoxFit.cover,
                        )))
                    .toList(),
              )),
              Card(
                elevation: 1 * SizeConfig.heightMultiplier,
                margin: EdgeInsets.all(2 * SizeConfig.heightMultiplier),
                child: Padding(
                  padding: EdgeInsets.all(1.5 * SizeConfig.heightMultiplier),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.filter_alt),
                            SizedBox(
                              width: 2 * SizeConfig.widthMultiplier,
                            ),
                            Text("Filters"),
                          ],
                        ),
                      ),
                      Container(
                          height: 3 * SizeConfig.heightMultiplier,
                          child: VerticalDivider(
                            color: Colors.black,
                          )),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (panelController.isPanelOpen) {
                              panelController.close();
                            } else {
                              panelController.open();
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.sort),
                              SizedBox(
                                width: 2 * SizeConfig.widthMultiplier,
                              ),
                              Text("Sorting")
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    1 * SizeConfig.heightMultiplier,
                    1 * SizeConfig.heightMultiplier,
                    1 * SizeConfig.heightMultiplier,
                    0),
                child: Text("My Favourite Barbers"),
              ),
              Card(
                elevation: 2 * SizeConfig.heightMultiplier,
                child: Container(
                    height: 32 * SizeConfig.heightMultiplier,
                    padding: EdgeInsets.symmetric(
                        vertical: 1.5 * SizeConfig.heightMultiplier),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _barbers.length,
                        itemBuilder: (BuildContext context, int index) {
                          return FavouriteBarberItem(_barbers[index]);
                        })),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    1 * SizeConfig.heightMultiplier,
                    3 * SizeConfig.heightMultiplier,
                    1 * SizeConfig.heightMultiplier,
                    0),
                child: Text("All Barbers"),
              ),
              Card(
                  elevation: 2 * SizeConfig.heightMultiplier,
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _barbers.length,
                      itemBuilder: (BuildContext context, int index) {
                        return BarberItem(_barbers[index]);
                      })),
            ],
          ),
        ),
      ],
    );
  }

  Widget radioUI(int value, Icon icon, String text) {
    bool isActive = _radioValue == value;
    Color activeColor = Colors.black;
    if (isActive) {
      activeColor = Colors.red;
    }
    return GestureDetector(
      onTap: () {
        _handleRadioValueChange(value);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 0, vertical: 1 * SizeConfig.heightMultiplier),
        child: Row(
          children: [
            Radio(
              value: value,
              groupValue: _radioValue,
              activeColor: activeColor,
              onChanged: _handleRadioValueChange,
            ),
            IconTheme(
              data: IconThemeData(color: activeColor),
              child: icon,
            ),
            SizedBox(width: 2 * SizeConfig.widthMultiplier),
            Expanded(
                child: Text(
              text,
              style: TextStyle(color: activeColor),
            )),
          ],
        ),
      ),
    );
  }

  Widget sortingUI() {
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
                "Sorting",
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
        Divider(
          height: 0 * SizeConfig.heightMultiplier,
          color: Colors.black45,
        ),
        radioUI(
            0, Icon(Icons.fiber_smart_record_sharp), "Smart Sorting (default)"),
        Divider(
          height: 0 * SizeConfig.heightMultiplier,
          color: Colors.black45,
        ),
        radioUI(1, Icon(Icons.star_border), "Barber Rating"),
        Divider(
          height: 0 * SizeConfig.heightMultiplier,
          color: Colors.black45,
        ),
        radioUI(2, Icon(Icons.map), "Location Based"),
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
            sortingUI(),
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
