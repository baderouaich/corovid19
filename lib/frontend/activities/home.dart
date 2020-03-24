import 'dart:convert';

import 'package:corovid19/frontend/activities/country_details_view.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import "../../backend/api/api.dart";
import "../../backend/models/country.dart";
import 'package:time_ago_provider/time_ago_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>
        [
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: (){

            },
          ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: (){

            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){

            },
          ),
        ],
        title: Text("Corovid-19"),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
            future: Api.getAll(),
            builder: (BuildContext ctx, AsyncSnapshot snapshot)
            {
              if (!snapshot.hasError && snapshot.hasData)
              {
                var response = snapshot.data;
                if (response["isError"])
                {
                  return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(response["message"],
                              style: TextStyle(color: Colors.white)),
                          leading: Icon(Icons.cloud_off),
                        ),
                      ));
                }
                else
                {
                  Map<String, dynamic> data = response["data"] ?? {};
                  List<Widget> widgets =
                  [
                     //Render Carousel first
                    if(data.isNotEmpty)
                      _buildCarouselSlider(data),

                    //Last updated
                     Center(
                       child: Text("Updated ${TimeAgo.getTimeAgo(data["updated"])}",
                       style: TextStyle(fontSize: 12.0)),
                     ),

                    //Divider
                    Divider(),

                    //Countries Tiles
                    FutureBuilder<Map<String, dynamic>>(
                      future: Api.getAllCountries(),
                      builder: (c, s) {
                        if (!s.hasError && s.hasData)
                        {
                          var response = snapshot.data;
                          if (response["isError"]) {
                            return Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    title: Text(response["message"],
                                        style: TextStyle(color: Colors.white)),
                                    leading: Icon(Icons.cloud_off),
                                  ),
                                ));
                          }
                          else
                            {
                              var countries = response["data"] ?? [];
                              List<Widget> items = [];
                              for(int i = 0; i < countries.length; i++)
                                  items.add(_buildCountryItem(countries[i], i));
                            return Column(children: items);

                          }
                        }
                        else
                          return Center(child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: CircularProgressIndicator(),
                          ));
                      }),

                  ];
                  return ListView.builder(
                      //shrinkWrap: true,
                      itemCount: widgets.length,
                      itemBuilder: (ctx, i)
                  {
                    return widgets[i];
                  });
                }
              }
              else return Center(child: CircularProgressIndicator());
            },
          )
    );
  }



  Widget _buildCarouselSlider(Map<String, dynamic> data)
  {
    /// 3 {Total cases, total recovered, total deaths}
    var radius =  BorderRadius.circular(15.0);
    print(data);
    List<Widget> items =
    [
      /// Total Cases
      Card(shape: RoundedRectangleBorder(borderRadius: radius),
        elevation: 7.0,
        margin: const EdgeInsets.all(12.0),
        child: Container(
          width: MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width * 0.20),
          height: MediaQuery.of(context).size.height * 0.25,
          child: ClipRRect(
              borderRadius: radius,
              child: Stack(
                children: <Widget>
                [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      constraints: BoxConstraints.expand(),
                      child:ClipRRect(
                          borderRadius: radius,
                          child:Image.asset("assets/cases.jpeg", fit:  BoxFit.cover)),
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
                      children: <Widget>
                      [
                        Text("${data["cases"]}", style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.w800
                        ),),
                        Text("Cases", style: TextStyle(
                            fontSize: 20.0,
                        ))
                      ],
                    ),
                  ),
                ],
              )
          )

        ),
      ),

      /// Total Recovered
      Card(shape: RoundedRectangleBorder(borderRadius: radius),
        elevation: 7.0,
        margin: const EdgeInsets.all(12.0),
        child: Container(
            width: MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width * 0.20),
            height: MediaQuery.of(context).size.height * 0.25,
            child: ClipRRect(
                borderRadius: radius,
                child: Stack(
                  children: <Widget>
                  [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        constraints: BoxConstraints.expand(),
                        child:ClipRRect(
                            borderRadius: radius,
                            child:Image.asset("assets/recovered.jpg", fit:  BoxFit.cover)),
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
                        children: <Widget>
                        [
                          Text("${data["recovered"]}", style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.w800
                          ),),
                          Text("Recovered", style: TextStyle(
                              fontSize: 20.0,
                          ))
                        ],
                      ),
                    ),
                  ],
                )
            )

        ),
      ),

      /// Total Deaths
      Card(shape: RoundedRectangleBorder(borderRadius: radius),
        elevation: 7.0,
        margin: const EdgeInsets.all(12.0),
        child: Container(
            width: MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width * 0.20),
            height: MediaQuery.of(context).size.height * 0.25,
            child: ClipRRect(
                borderRadius: radius,
                child: Stack(
                  children: <Widget>
                  [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        constraints: BoxConstraints.expand(),
                        child:ClipRRect(
                            borderRadius: radius,
                            child:Image.asset("assets/deaths.jpg", fit:  BoxFit.cover)),
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
                        children: <Widget>
                        [
                          Text("${data["deaths"]}", style: TextStyle(
                              fontSize: 40.0,
                            fontWeight: FontWeight.w800
                          ),),
                          Text("Deaths", style: TextStyle(
                              fontSize: 20.0,
                          ))
                        ],
                      ),
                    ),


                  ],
                )
            )

        ),
      ),
    ];
    return CarouselSlider(
      items: items,
      height: MediaQuery.of(context).size.height / 2.5, // 25% of the screen
      aspectRatio: 16/9,
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
      onPageChanged: (int index)
      {

      },
      scrollDirection: Axis.horizontal,
    );


  }



  Widget _buildCountryItem(Map<String, dynamic> country, int index)
  {

    return Card(elevation: 5.0,
        child: ListTile(
          onTap: ()
          {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: CountryDetailsView(countryName: country["country"]),
                    duration: Duration(seconds: 2)));
          },
        leading: Image.network(country["countryInfo"]["flag"], width: 30, height: 30),
          title: Text(country["country"], style: TextStyle(fontSize: 18.0,
              fontWeight: FontWeight.w500),),
          subtitle: Text("${country["cases"]}", style: TextStyle(fontSize: 20.0,
              fontWeight: FontWeight.w800),),
          trailing: IconButton(icon: Icon(index.isEven ? Icons.star_border : Icons.star),
            color: Colors.amber, onPressed: ()
            {
              //add country name to favories
            },
          ),

    ));
  }
}
