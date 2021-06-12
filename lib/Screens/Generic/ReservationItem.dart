import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_barber/Models/Barber.dart';
import 'package:my_barber/Models/HelperModels/ReservationHelper.dart';
import 'package:my_barber/Models/Review.dart';
import 'package:my_barber/Models/Users.dart';
import 'package:my_barber/Screens/Generic/SystemUI.dart';
import 'package:my_barber/Services/DatabaseHelper.dart';
import 'package:my_barber/Utils/size_config.dart';

import 'BarberDetailItem.dart';

class ReservationItem extends StatefulWidget {
  ReservationHelper reservationHelper;
  Users user;
  bool isInHistory;

  ReservationItem(this.reservationHelper, this.isInHistory, this.user);

  @override
  _ReservationItemState createState() => _ReservationItemState();
}

class _ReservationItemState extends State<ReservationItem> {
  bool isExpanded = false;
  String review;
  int star;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      child: Container(
        padding: EdgeInsets.all(8),
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                            widget.reservationHelper.barber.name,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 1.7 * SizeConfig.textMultiplier),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 4, 8, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            color: Theme
                                .of(context)
                                .primaryColorDark,
                          ),
                          Flexible(
                            child: Text(
                              " ${widget.reservationHelper.date} - ${widget
                                  .reservationHelper.time}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontSize: 1.5 * SizeConfig.textMultiplier),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 4, 8, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.fiber_smart_record,
                            color: Theme
                                .of(context)
                                .primaryColorDark,
                          ),
                          Text(
                            " ${widget.reservationHelper.service}",
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 1.7 * SizeConfig.textMultiplier),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
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
                            vertical: 1 * SizeConfig.heightMultiplier),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: Theme
                                  .of(context)
                                  .primaryColorDark,
                              size: 4 * SizeConfig.imageSizeMultiplier,
                            ),
                            new Text(
                              " ${widget.reservationHelper.barber.stars}",
                              style: TextStyle(
                                  color: Theme
                                      .of(context)
                                      .primaryColorDark,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 1.7 * SizeConfig.textMultiplier),
                            ),
                            Text(
                                "(${widget.reservationHelper.barber.reviews
                                    .length}+)",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize:
                                    1.5 * SizeConfig.textMultiplier))
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.bookmark_border,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          widget.isInHistory
              ? GestureDetector(
            onTap: () {
              setState(() {
                if (isExpanded == false) {
                  isExpanded = true;
                } else {
                  isExpanded = false;
                }
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Evaluate Service",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Theme
                          .of(context)
                          .primaryColorDark,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          )
              : SizedBox(),
          isExpanded
              ? Form(
              key: _formKey,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        SizeConfig.heightMultiplier)),
                elevation: SizeConfig.heightMultiplier,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 6 * SizeConfig.widthMultiplier,
                      vertical: SizeConfig.heightMultiplier),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RatingBar.builder(
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemPadding:
                            EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) =>
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                            onRatingUpdate: (rating) {
                              setState(() {
                                star = rating.toInt();
                                print(star);
                              });
                            },
                          ),
                        ],
                      ),
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        validator: (input) {
                          if (input.isEmpty) {
                            return "Write Your Review";
                          }
                          return null;
                        },
                        onSaved: (input) {
                          review = input;
                        },
                        decoration: InputDecoration(
                          labelText: "Review",
                        ),
                      ),
                      SizedBox(
                        height: 3 * SizeConfig.heightMultiplier,
                      ),
                      SystemUI().cancelButton(makeReview,
                          text: "Submit",
                          backgroundColor:
                          Theme
                              .of(context)
                              .primaryColorDark)
                    ],
                  ),
                ),
              ))
              : SizedBox()
        ]),
      ),
    );
  }

  void makeReview() {
    final formState = _formKey.currentState;


    if (formState.validate()) {
      formState.save();

      Review model = Review("review"+DateTime
          .now()
          .millisecondsSinceEpoch
          .toString(), review, star, DateTime
          .now()
          .millisecondsSinceEpoch, widget.user.name);

      DatabaseHelper().submitReview(widget.reservationHelper.barber.ID, model);

      final scaffold = Scaffold.of(context);
      scaffold.showSnackBar(
        SnackBar(
          content: const Text('Your Review is done.'),
        ),
      );

      setState(() {
        isExpanded = false;
      });


      print(review);
    }
  }
}
