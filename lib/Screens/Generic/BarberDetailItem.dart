import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_barber/Models/Barber.dart';
import 'package:my_barber/Screens/Generic/ReviewItem.dart';
import 'package:my_barber/Utils/size_config.dart';

class BarberDetailItem extends StatefulWidget {
  Barber barber;

  BarberDetailItem(this.barber);

  @override
  _BarberDetailItemState createState() => _BarberDetailItemState();
}

class _BarberDetailItemState extends State<BarberDetailItem> {
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
                height: 60 * SizeConfig.heightMultiplier,
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
                                                  SizeConfig.textMultiplier)),
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
                            child: Text("Hizmetler")),
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
}
