import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_barber/Models/Review.dart';
import 'package:my_barber/Utils/size_config.dart';
import 'package:intl/intl.dart';

class ReviewItem extends StatefulWidget {
  Review review;

  ReviewItem(this.review);

  @override
  _ReviewItemState createState() => _ReviewItemState();
}

class _ReviewItemState extends State<ReviewItem> {
  @override
  Widget build(BuildContext context) {
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipOval(
                  child: Material(
                    color: Colors.grey[300], // Button color
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.person,
                        size: 8 * SizeConfig.imageSizeMultiplier,
                      ),
                    ),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                widget.review.user,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 1.7 * SizeConfig.textMultiplier),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                Text(
                                  " ${widget.review.star}",
                                  style: TextStyle(
                                      color: Colors.grey[800],
                                      fontSize:
                                          1.5 * SizeConfig.textMultiplier),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 5 * SizeConfig.widthMultiplier,
                            ),
                            Text(
                              "${DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(widget.review.time)).toString()}",
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontSize: 1.5 * SizeConfig.textMultiplier),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(8, 4, 8, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.comment,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            SizedBox(
                              width: 2 * SizeConfig.widthMultiplier,
                            ),
                            Flexible(
                              child: Text(
                                widget.review.comment,
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: 1.5 * SizeConfig.textMultiplier),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
