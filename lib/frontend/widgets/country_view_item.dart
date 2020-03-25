import 'package:flutter/material.dart';
import '../../backend/storage/storage.dart';
import '../activities/country_details_view.dart';
import 'package:page_transition/page_transition.dart';

/// We need state management for updating favorite icon star,
/// and so calling setState() will update only the state of this widget, not the whole main Scaffold view
class CountryViewItem extends StatefulWidget {
  final country; // data country
  CountryViewItem(this.country);
  @override
  _CountryViewItemState createState() => _CountryViewItemState();
}
class _CountryViewItemState extends State<CountryViewItem> {
  Storage storage;
  @override
  void initState() {
    storage = new Storage();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Card(elevation: 2.0,
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  child: CountryDetailsView(
                      countryName: widget.country["country"]),
                  duration: Duration(seconds: 2)));
        },
        title: Text(widget.country["country"], style: TextStyle(fontSize: 18.0,
            fontWeight: FontWeight.w500),),
        leading: Image.network(
            widget.country["countryInfo"]["flag"], width: 30, height: 30),
        subtitle: Text(
          "${widget.country["cases"]}", style: TextStyle(fontSize: 20.0,
            fontWeight: FontWeight.w800),),

        trailing: FutureBuilder<bool>
          (
            future: storage.isFavorite(widget.country["country"]),
            builder: (c, s) {
              if (s.hasData && !s.hasError) {
                bool isFavorite = s.data;
                return IconButton(
                    icon: Icon(isFavorite ? Icons.star : Icons.star_border),
                    color: Colors.amber,
                    onPressed: () {
                      //add country name to favorites
                      setState(() {
                        if (isFavorite)
                          storage.removeFavorite(widget.country["country"]);
                        else
                          storage.addFavorite(widget.country["country"]);
                      });
                    });
              }
              else
                return CircularProgressIndicator();
            }),
      ),
    );
  }

}
