class AllDetails
{

  int updated;
  int cases;
  int todayCases;
  int deaths;
  int todayDeaths;
  int recovered;
  int active;
  int critical;
  int tests;
  int affectedCountries;


  AllDetails({this.updated,
             this.cases, 
             this.todayCases, 
             this.deaths,
             this.todayDeaths,
             this.recovered,
             this.active,
             this.critical,
             this.tests,
             this.affectedCountries});

  factory AllDetails.fromJson(dynamic json)
  {
    return AllDetails
      (
        updated: json["updated"] as int,
        cases: json["cases"] as int,
        todayCases: json["todayCases"] as int,
        deaths: json["deaths"] as int,
        todayDeaths: json["todayDeaths"] as int,
        recovered: json["recovered"] as int,
        active: json["active"] as int,
        critical: json["critical"] as int,
        tests: json["tests"] as int,
        affectedCountries: json["affectedCountries"] as int
      );
  }
}