import 'package:carousel_slider/carousel_slider.dart';
import '../../backend/models/all_details.dart';
import 'package:flutter/material.dart';

class CasesCarouselSlider extends StatefulWidget {
  final AllDetails allDetails;
  CasesCarouselSlider(this.allDetails);
  @override
  _CasesCarouselSliderState createState() => _CasesCarouselSliderState();
}

class _CasesCarouselSliderState extends State<CasesCarouselSlider> {
  @override
  Widget build(BuildContext context) {
    /// 3 {Total cases, total recovered, total deaths}
    var radius = BorderRadius.circular(15.0);
    List<Widget> items = 
    [
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
                            "${widget.allDetails.cases}",
                            style: TextStyle(color: const Color(0xffffffff),
                                fontSize: 40.0, fontWeight: FontWeight.w800),
                          ),
                          Text("Cases",
                              style: TextStyle(color: const Color(0xffffffff),
                                fontSize: 20.0,
                              ))
                        ],
                      ),
                    ),
                  ],
                ))),
      ),


      /// Today Cases
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
                            "${widget.allDetails.todayCases}",
                            style: TextStyle(color: const Color(0xffffffff),
                                fontSize: 40.0, fontWeight: FontWeight.w800),
                          ),
                          Text("Today Cases",
                              style: TextStyle(color: const Color(0xffffffff),
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
                            "${widget.allDetails.recovered}",
                            style: TextStyle(color: const Color(0xffffffff),
                                fontSize: 40.0, fontWeight: FontWeight.w800),
                          ),
                          Text("Recovered",
                              style: TextStyle(color: const Color(0xffffffff),
                                fontSize: 20.0,
                              ))
                        ],
                      ),
                    ),
                  ],
                ))),
      ),



      /// Active
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
                            child: Image.asset("assets/active.jpg",
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
                            "${widget.allDetails.active}",
                            style: TextStyle(color: const Color(0xffffffff),
                                fontSize: 40.0, fontWeight: FontWeight.w800),
                          ),
                          Text("Active",
                              style: TextStyle(color: const Color(0xffffffff),
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
                            "${widget.allDetails.deaths}",
                            style: TextStyle(color: const Color(0xffffffff),
                                fontSize: 40.0, fontWeight: FontWeight.w800),
                          ),
                          Text("Deaths",
                              style: TextStyle(color: const Color(0xffffffff),
                                fontSize: 20.0,
                              ))
                        ],
                      ),
                    ),
                  ],
                ))),
      ),
    
    
      /// Today Deaths
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
                            "${widget.allDetails.todayDeaths}",
                            style: TextStyle(color: const Color(0xffffffff),
                                fontSize: 40.0, fontWeight: FontWeight.w800),
                          ),
                          Text("Today Deaths",
                              style: TextStyle(color: const Color(0xffffffff),
                                fontSize: 20.0,
                              ))
                        ],
                      ),
                    ),
                  ],
                ))),
      ),
    

      /// Critical
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
                            child: Image.asset("assets/critical.jpg",
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
                            "${widget.allDetails.critical}",
                            style: TextStyle(color: const Color(0xffffffff),
                                fontSize: 40.0, fontWeight: FontWeight.w800),
                          ),
                          Text("Critical",
                              style: TextStyle(color: const Color(0xffffffff),
                                fontSize: 20.0,
                              ))
                        ],
                      ),
                    ),
                  ],
                ))),
      ),
    



      /// Total Tests
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
                            child: Image.asset("assets/tests.jpg",
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
                            "${widget.allDetails.tests}",
                            style: TextStyle(color: const Color(0xffffffff),
                                fontSize: 40.0, fontWeight: FontWeight.w800),
                          ),
                          Text("Total Tests",
                              style: TextStyle(color: const Color(0xffffffff),
                                fontSize: 20.0,
                              ))
                        ],
                      ),
                    ),
                  ],
                ))),
      ),
    



    
      /// Affected countries
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
                            child: Image.asset("assets/countries.jpg",
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
                            "${widget.allDetails.affectedCountries}",
                            style: TextStyle(color: const Color(0xffffffff),
                                fontSize: 40.0, fontWeight: FontWeight.w800),
                          ),
                          Text("Affected Countries",
                              style: TextStyle(color: const Color(0xffffffff),
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
