
import 'package:flutter/material.dart';

import '../../backend/api/api.dart';

class CountryDetailsView extends StatefulWidget
{
  final String countryName;
  CountryDetailsView({this.countryName});
  @override
  _CountryDetailsViewState createState() => _CountryDetailsViewState();
}

class _CountryDetailsViewState extends State<CountryDetailsView>
{

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
    appBar: AppBar(title: Text(widget.countryName), centerTitle: true),
      body: FutureBuilder<Map<String, dynamic>>(
        future: Api.getCountry(widget.countryName),
        builder: (ctx, snapshot)
        {
          if(!snapshot.hasError && snapshot.hasData)
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
                  var country = response["data"] ?? {};
                  print("Got: " + country);
                  List<Widget> items =
                      [
                        ///Render Flag at first
                        Image.network(country["countryInfo"]["flag"], fit: BoxFit.cover, width: MediaQuery.of(context).size.width),

                        /// Data
                        ListTile(
                          title: Text("Total Cases"),
                          trailing: Text("${country["cases"]}"),
                        ),
                        ListTile(
                          title: Text("Today Cases"),
                          trailing: Text("${country["todayCases"]}"),
                        ),
                        Divider(),


                        ListTile(
                          title: Text("Total Deaths"),
                          trailing: Text("${country["deaths"]}"),
                        ),
                        ListTile(
                          title: Text("Today Deaths"),
                          trailing: Text("${country["todayDeaths"]}"),
                        ),
                        ListTile(
                          title: Text("Total Recovered"),
                          trailing: Text("${country["recovered"]}"),
                        ),

                        Divider(),
                        ListTile(
                          title: Text("Active"),
                          trailing: Text("${country["active"]}"),
                        ),
                        ListTile(
                          title: Text("Critical"),
                          trailing: Text("${country["critical"]}"),
                        ),
                        ListTile(
                          title: Text("Cases Per One Million"),
                          trailing: Text("${country["casesPerOneMillion"]}"),
                        ),
                        ListTile(
                          title: Text("Deaths Per One Million"),
                          trailing: Text("${country["deathsPerOneMillion"]}"),
                        ),


                      ];

                  return SingleChildScrollView(physics: BouncingScrollPhysics(), child: Column(children: items));
                }

            }
          else return Center(child: Column(
            children: <Widget>[
              Text("Loading Data..."),
              LinearProgressIndicator(),
            ],
          ));
        },
      ),
    );
  }
}
