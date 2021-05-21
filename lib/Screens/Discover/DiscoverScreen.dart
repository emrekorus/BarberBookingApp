import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_barber/Utils/size_config.dart';

class DiscoverScreen extends StatefulWidget {
  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  List<int> list = [1, 2, 3, 4, 5];
  List<String> list2 = [
    "https://cdn2.coachmag.co.uk/sites/coachmag/files/styles/16x9_480/public/2018/02/how-to-style-hair.jpg?itok=PJugL8Mk&timestamp=1519728204"
    "https://italiansbarber.com/wp-content/uploads/2016/05/mens-haircuts-brown-short-hair_1024x1024-2.jpg",
    "https://hips.hearstapps.com/esq.h-cdn.co/assets/17/29/1500667303-es-072117-talk-to-your-barber-about-your-hair.jpg",
    "https://www.kangan.edu.au/assets/images/blog/reasons-you-should-become-a-barber/2.jpg",
    "https://www.inquirer.com/resizer/orhvGzXeXNLr2xpL6_d81Lv-IQE=/1400x932/smart/arc-anglerfish-arc2-prod-pmn.s3.amazonaws.com/public/PTR2I5SGUNHJJGUGMHSGXFFCKU.jpg",
    "https://media.istockphoto.com/photos/man-at-hair-salon-picture-id1096942782?k=6&m=1096942782&s=612x612&w=0&h=hNsfntxzrugUlXin9Pv1GpHKdHfdfpRGvIWRk5ETZVw=",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.only(top: 8),
            child: CarouselSlider(
              options: CarouselOptions(
                  enlargeCenterPage: true,
                  aspectRatio: 3.0,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3)),
              items: list
                  .map((item) => Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                2 * SizeConfig.heightMultiplier),
                            color: Colors.green),
                        child: Center(child: Text(item.toString())),
                      ))
                  .toList(),
            )),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(top: 8),
            child: ListView.builder(
                itemCount: list2.length,
                itemBuilder: (context, index) {
                  return ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        list2[index],
                        fit: BoxFit.fill,
                      ));
                }),
          ),
        )
      ],
    );
  }
}
