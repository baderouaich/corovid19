import 'package:flutter/material.dart';

import '../../backend/storage/storage.dart';
import '../../backend/models/country.dart';

class CountryDetailsView extends StatefulWidget
{
  final Country country;
  CountryDetailsView({this.country});
  @override
  _CountryDetailsViewState createState() => _CountryDetailsViewState();
}

class _CountryDetailsViewState extends State<CountryDetailsView>
{
  Storage storage;
  @override
  void initState() {
    storage = new Storage();
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    List<Widget> items =
    [
      ///Render Flag at first
      Image.network(widget.country.countryInfo.flag, fit: BoxFit.cover, width: MediaQuery.of(context).size.width),

      /// Data
      ListTile(
        title: Text("Total Cases"),
        trailing: Text("${widget.country.cases}"),
      ),
      ListTile(
        title: Text("Today Cases"),
        trailing: Text("${widget.country.todayCases}"),
      ),
      Divider(),


      ListTile(
        title: Text("Total Deaths"),
        trailing: Text("${widget.country.deaths}"),
      ),
      ListTile(
        title: Text("Today Deaths"),
        trailing: Text("${widget.country.todayDeaths}"),
      ),
      ListTile(
        title: Text("Total Recovered"),
        trailing: Text("${widget.country.recovered}"),
      ),

      Divider(),
      ListTile(
        title: Text("Active"),
        trailing: Text("${widget.country.active}"),
      ),
      ListTile(
        title: Text("Critical"),
        trailing: Text("${widget.country.critical}"),
      ),
      ListTile(
        title: Text("Cases Per One Million"),
        trailing: Text("${widget.country.casesPerOneMillion}"),
      ),
      ListTile(
        title: Text("Deaths Per One Million"),
        trailing: Text("${widget.country.deathsPerOneMillion}"),
      ),


    ];

    return Scaffold(
    appBar: AppBar(title: Text(widget.country.name), centerTitle: true,
    actions: <Widget>
    [
      FutureBuilder<bool>
        (
          future: storage.isFavorite(widget.country.name),
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
                        storage.removeFavorite(widget.country.name);
                      else
                        storage.addFavorite(widget.country.name);
                    });
                  });
            }
            else
              return CircularProgressIndicator();
          })
    ],),
      body: SingleChildScrollView(physics: BouncingScrollPhysics(), child: Column(children: items))
    );
  }
}
