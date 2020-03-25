
import 'package:flutter/material.dart';

import '../../backend/api/api.dart';
import '../../backend/storage/storage.dart';

class CountryDetailsView extends StatefulWidget
{
  final String countryName;
  CountryDetailsView({this.countryName});
  @override
  _CountryDetailsViewState createState() => _CountryDetailsViewState();
}

class _CountryDetailsViewState extends State<CountryDetailsView>
{
  Api api;
  Storage storage;

  @override
  void initState() {
    storage = new Storage();
    super.initState();
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
    appBar: AppBar(title: Text(widget.countryName), centerTitle: true,
    actions: <Widget>
    [
      FutureBuilder<bool>
        (
          future: storage.isFavorite(widget.countryName),
          builder: (c, s)
          {
            if(s.hasData && !s.hasError)
            {
              bool isFavorite = s.data;
              return IconButton(
                  icon: Icon(isFavorite ? Icons.star : Icons.star_border),
                  color: Colors.amber,
                  onPressed: ()
                  {
                    //add country name to favorites
                    setState(() {
                      if(isFavorite)
                        storage.removeFavorite(widget.countryName);
                      else
                        storage.addFavorite(widget.countryName);
                    });
                  });
            }
            else
              return CircularProgressIndicator();
          })
    ],),
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
          else return Center(child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Loading Data..."),
                Divider(),
                LinearProgressIndicator(),
              ],
            ),
          ));
        },
      ),
    );
  }
}
