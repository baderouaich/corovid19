/// Using almost all model data types as var to prevent API data changes as latitude & longitude which
/// is double in some items, and integer in another.
/// https://stackoverflow.com/questions/55710579/how-to-parse-complex-json-in-flutter
class Country
{
  var name;
  CountryInfo countryInfo;
  var cases, todayCases, deaths, todayDeaths, recovered, active,
      critical, casesPerOneMillion, deathsPerOneMillion;
  Country({this.name, this.countryInfo, this.cases, this.todayCases,
    this.deaths, this.todayDeaths, this.recovered,
    this.active, this.critical, this.casesPerOneMillion, this.deathsPerOneMillion});

  factory Country.fromJson(dynamic json)
  {
    return Country(
        name: json['country'],
        cases: json['cases'],
        countryInfo: CountryInfo.fromJson(json["countryInfo"]),
        todayCases: json['todayCases'],
        deaths: json['deaths'],
        todayDeaths: json['todayDeaths'],
        recovered: json['recovered'],
        active: json['active'],
        critical: json['critical'],
        casesPerOneMillion: json['casesPerOneMillion'],
        deathsPerOneMillion: json['deathsPerOneMillion'],
    );
  }
}

class CountryInfo
{
  var iso2, iso3, flag;
  var id;
  var lat, long; 

  CountryInfo({this.iso2, this.iso3, this.id, this.flag,
  this.lat, this.long});

  factory CountryInfo.fromJson(dynamic json)
  {
    return CountryInfo(
      iso2: json['iso2'],
      iso3: json['iso3'],
      id: json['_id'],
      flag: json['flag'],
      lat: json['lat']
    );
  }
}