import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_barber/Models/Barber.dart';
import 'package:my_barber/Models/Users.dart';
import 'package:my_barber/Utils/size_config.dart';

import 'BarberDetailItem.dart';

class BarberItem extends StatefulWidget {
  Barber barber;
  Users user;

  BarberItem(this.barber, this.user);

  @override
  _BarberItemState createState() => _BarberItemState();
}

class _BarberItemState extends State<BarberItem> {


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BarberDetailItem(widget.barber, widget.user),
            ));
      },
      child: Card(
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
                    borderRadius:
                        BorderRadius.circular(2 * SizeConfig.heightMultiplier),
                    child: Image.network(
                      widget.barber.image,
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
                                Icons.map,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              Flexible(
                                child: Text(
                                  " ${widget.barber.address}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.grey[800],
                                      fontSize:
                                          1.5 * SizeConfig.textMultiplier),
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
                                Icons.location_on_outlined,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              Text(
                                "${widget.barber.distance.toStringAsFixed(2)} km",
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
                                  color: Theme.of(context).primaryColorDark,
                                  size: 4 * SizeConfig.imageSizeMultiplier,
                                ),
                                new Text(
                                  " ${widget.barber.stars}",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColorDark,
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          1.7 * SizeConfig.textMultiplier),
                                ),
                                Text("(${widget.barber.reviews.length}+)",
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
            ),
          ]),
        ),
      ),
    );
  }
}
