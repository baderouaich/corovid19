import '../../backend/storage/storage.dart';
import 'package:flutter/material.dart';
import "../../backend/api/api.dart";
import 'package:time_ago_provider/time_ago_provider.dart';
import '../widgets/cases_carousel_slider.dart';
import '../widgets/country_view_item.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
{
  Storage storage;

  @override
  void initState() {
    storage = new Storage();
    super.initState();
  }
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
                Map<String, dynamic> response = snapshot.data;
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
                      new CasesCarouselSlider(data),

                    //Last updated
                     Center(
                       child: Text("Updated ${TimeAgo.getTimeAgo(data["updated"])}",
                       style: TextStyle(fontSize: 12.0)),
                     ),

                    //Divider
                    Divider(),

                    //Countries Tiles
                    _renderCountriesTilesList()

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



  Widget _renderCountriesTilesList()
  {
    return FutureBuilder<Map<String, dynamic>>(
        future: Api.getAllCountries(),
        builder: (c, s) {
          if (!s.hasError && s.hasData)
          {
            var response = s.data;
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
              var countries = response["data"] ?? [];
              ///Sort by favorites
            /*  for(int i = 0; i < countries.length - 1; i++)
                {
                  for(int j = i + 1; j < countries.length; j++)
                    {
                      if(storage.isFavorite(countries[i]["country"]))
                      {
                          var temp = countries[i];
                          countries[i] = countries[j];
                          countries[j] = temp;
                      }

                    }
                }*/
              countries.sort((a, b) {
                return a['country'].toString().toLowerCase().compareTo(b['country'].toString().toLowerCase());
              });

              List<Widget> items = [];
              for(int i = 0; i < countries.length; i++)
                items.add(new CountryViewItem(countries[i]));
              //items.add(_buildCountryItem(countries[i], i));
              return Column(children: items);
            }
          }
          else
            return Center(child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: CircularProgressIndicator(),
            ));
        });

  }

}



