import '../../backend/models/country.dart';

import '../../backend/storage/storage.dart';
import 'package:flutter/material.dart';
import "../../backend/api/api.dart";
import "../../backend/models/all_details.dart";
import 'package:time_ago_provider/time_ago_provider.dart';
import '../widgets/cases_carousel_slider.dart';
import '../widgets/country_view_item.dart';
import '../../backend/models/sort_by.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {
  AllDetails allDetails;
  List<Country> countriesList;
  Storage storage;

  bool isLoadingDetails = true;
  bool isLoadingCountries = true;

  //Default sort by favorite
  String sortBy;

  bool isSearching = false;
  List<Country> searchCountriesList = [];
  void search(final String countryName)
  {
    if(mounted)
      setState((){
        searchCountriesList.insert(0,  countriesList.firstWhere((country) =>
            country.name.toLowerCase().contains(countryName.toLowerCase()) &&
                !searchCountriesList.contains(country)));
          });
  }


  void loadApiData() async {
    if (mounted)
      setState(() {
        isLoadingDetails = true;
        isLoadingCountries = true;
      });

    //Get All Details Carousel
    var res1 = await Api.getAll();
    if (mounted)
      setState(() {
        allDetails = (res1["data"] ??
                AllDetails(cases: 0, deaths: 0, recovered: 0, updated: 0))
            as AllDetails;
        isLoadingDetails = false;
      });

    //get sort by param
    sortBy = await storage.getSortByParam();

    //Get All Countries List Tiles
    var res2 = await Api.getAllCountries(sortBy);
    if (mounted)
      setState(() {
        countriesList = (res2["data"] ?? []) as List<Country>;
        isLoadingCountries = false;
      });
  }

  @override
  void initState() {
    storage = new Storage();
    loadApiData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      //Render Carousel first
      isLoadingDetails
          ?
      Center(child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: CircularProgressIndicator(),
      ))
          : CasesCarouselSlider(allDetails),

      //Last updated
      if (!isLoadingDetails && !isLoadingCountries)
        Center(
          child: Text(
              "Updated ${TimeAgo.getTimeAgo(allDetails.updated ?? DateTime.now().millisecondsSinceEpoch)}",
              style: TextStyle(fontSize: 12.0)),
        ),

      //Divider
      Divider(),

      //Countries Tiles
      isLoadingCountries
          ?
      Center(child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: CircularProgressIndicator(),
          ))
          : _renderCountriesTilesList()
    ];

    return Scaffold(
      appBar: _renderAppBar(),
      body: SingleChildScrollView(physics: BouncingScrollPhysics(), child: Column(children: widgets)),
    );
  }

  Widget _renderAppBar() {
    return isSearching
        ? AppBar(
            elevation: 5.0,
            actions: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          width: 250,
                          child: TextField(
                            autofocus: true, //requests focus when it appears
                            onChanged: (query)
                            {
                              search(query);
                            },
                            onSubmitted: (query)
                            {
                              search(query);
                            },
                            decoration: InputDecoration(hintText: "Country name..."),
                          ),
                        ),
                        IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              if (mounted)
                                setState(() {
                                  isSearching = false;
                                  searchCountriesList.clear();
                                });
                            })
                      ]))
            ],
          )
        : AppBar(
            elevation: 5.0,
            actions: <Widget>
            [
              ///Sort By
              PopupMenuButton<String>(
                tooltip: 'Sort by',
                icon: Icon(Icons.sort),

                onSelected: (param)
                {
                  print(param);
                  if(mounted)
                    setState(()
                    {
                      sortBy = param;
                      storage.setSortByParam(param);
                      loadApiData();
                    });

                },
                itemBuilder: (BuildContext c) =>
                <PopupMenuEntry<String>>
                [
                  PopupMenuItem(child: Text("Sort By"), enabled: false, textStyle: TextStyle(fontWeight: FontWeight.w800)),
                  for(final String param in SortBy.parameters)
                    PopupMenuItem<String>(child: Text(param), value: param),
                ],
              ),

              ///Search
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  if(mounted)
                    setState((){
                     isSearching = true;
                    });
                },
              ),


              ///Refresh
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  loadApiData();
                },
              ),
            ],
            title: Text("Corovid-19"),
          );
  }

  Widget _renderCountriesTilesList()
  {
    List<Widget> widgets = [];
    for(final Country country in (isSearching ? searchCountriesList : countriesList))
        widgets.add(new CountryViewItem(country));
    return  Column(children: widgets);
  }
}

/*
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
{
  List<Country> countriesList;
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
                  AllDetails allDetails = response["data"];
                  List<Widget> widgets =
                  [
                     //Render Carousel first
                     new CasesCarouselSlider(allDetails),

                    //Last updated
                     Center(
                       child: Text("Updated ${TimeAgo.getTimeAgo(allDetails.updated ?? DateTime.now().millisecondsSinceEpoch)}",
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
              countriesList = (response["data"] ?? []) as List<Country>;

              List<Widget> items = [];
              for(int i = 0; i < countriesList.length; i++)
                items.add(new CountryViewItem(countriesList[i]));
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



*/
