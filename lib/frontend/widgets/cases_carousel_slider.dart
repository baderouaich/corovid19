import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CasesCarouselSlider extends StatefulWidget {
  final Map<String, dynamic> data;
  CasesCarouselSlider(this.data);
  @override
  _CasesCarouselSliderState createState() => _CasesCarouselSliderState();
}

class _CasesCarouselSliderState extends State<CasesCarouselSlider> {
  @override
  Widget build(BuildContext context) {
    /// 3 {Total cases, total recovered, total deaths}
    var radius = BorderRadius.circular(15.0);
    List<Widget> items = [
      /// Total Cases
      Card(
        shape: RoundedRectangleBorder(borderRadius: radius),
        elevation: 7.0,
        margin: const EdgeInsets.all(12.0),
        child: Container(
            width: MediaQuery.of(context).size.width -
                (MediaQuery.of(context).size.width * 0.20),
            height: MediaQuery.of(context).size.height * 0.25,
            child: ClipRRect(
                borderRadius: radius,
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        constraints: BoxConstraints.expand(),
                        child: ClipRRect(
                            borderRadius: radius,
                            child: Image.asset("assets/cases.jpeg",
                                fit: BoxFit.cover)),
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints.expand(),
                      color: Colors.blueGrey[600].withOpacity(0.50),
                      child: Container(),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "${widget.data["cases"]}",
                            style: TextStyle(
                                fontSize: 40.0, fontWeight: FontWeight.w800),
                          ),
                          Text("Cases",
                              style: TextStyle(
                                fontSize: 20.0,
                              ))
                        ],
                      ),
                    ),
                  ],
                ))),
      ),

      /// Total Recovered
      Card(
        shape: RoundedRectangleBorder(borderRadius: radius),
        elevation: 7.0,
        margin: const EdgeInsets.all(12.0),
        child: Container(
            width: MediaQuery.of(context).size.width -
                (MediaQuery.of(context).size.width * 0.20),
            height: MediaQuery.of(context).size.height * 0.25,
            child: ClipRRect(
                borderRadius: radius,
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        constraints: BoxConstraints.expand(),
                        child: ClipRRect(
                            borderRadius: radius,
                            child: Image.asset("assets/recovered.jpg",
                                fit: BoxFit.cover)),
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints.expand(),
                      color: Colors.blueGrey[600].withOpacity(0.50),
                      child: Container(),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "${widget.data["recovered"]}",
                            style: TextStyle(
                                fontSize: 40.0, fontWeight: FontWeight.w800),
                          ),
                          Text("Recovered",
                              style: TextStyle(
                                fontSize: 20.0,
                              ))
                        ],
                      ),
                    ),
                  ],
                ))),
      ),

      /// Total Deaths
      Card(
        shape: RoundedRectangleBorder(borderRadius: radius),
        elevation: 7.0,
        margin: const EdgeInsets.all(12.0),
        child: Container(
            width: MediaQuery.of(context).size.width -
                (MediaQuery.of(context).size.width * 0.20),
            height: MediaQuery.of(context).size.height * 0.25,
            child: ClipRRect(
                borderRadius: radius,
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        constraints: BoxConstraints.expand(),
                        child: ClipRRect(
                            borderRadius: radius,
                            child: Image.asset("assets/deaths.jpg",
                                fit: BoxFit.cover)),
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints.expand(),
                      color: Colors.blueGrey[700].withOpacity(0.50),
                      child: Container(),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "${widget.data["deaths"]}",
                            style: TextStyle(
                                fontSize: 40.0, fontWeight: FontWeight.w800),
                          ),
                          Text("Deaths",
                              style: TextStyle(
                                fontSize: 20.0,
                              ))
                        ],
                      ),
                    ),
                  ],
                ))),
      ),
    ];
    return CarouselSlider(
      items: items,
      height: MediaQuery.of(context).size.height / 2.5, // 25% of the screen
      aspectRatio: 16 / 9,
      viewportFraction: 0.8,
      initialPage: 0,
      enableInfiniteScroll: true,
      reverse: false,
      autoPlay: true,
      autoPlayInterval: Duration(seconds: 3),
      autoPlayAnimationDuration: Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      pauseAutoPlayOnTouch: Duration(seconds: 10),
      enlargeCenterPage: true,
      onPageChanged: (int index) {},
      scrollDirection: Axis.horizontal,
    );
  }
}
