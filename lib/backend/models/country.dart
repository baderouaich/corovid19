class Country
{
  var country; //name
  CountryInfo countryInfo;
  var cases, todayCases, deaths, todayDeaths, recovered, active,
      critical, casesPerOneMillion, deathsPerOneMillion;
  Country({this.country, this.countryInfo, this.cases, this.todayCases,
    this.deaths, this.todayDeaths, this.recovered,
    this.active, this.critical, this.casesPerOneMillion, this.deathsPerOneMillion});

  factory Country.fromJson(dynamic json)
  {
    return Country(
        country: json['country'],
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
  var lat, long; //as var, data has mixed lat & lang double or int types

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