class AllDetails
{
  int cases, deaths, recovered, updated;

  AllDetails({this.cases, this.deaths, this.recovered, this.updated});

  factory AllDetails.fromJson(dynamic json)
  {
    return AllDetails
      (
        cases: json["cases"] as int,
        deaths: json["deaths"] as int,
        recovered: json["recovered"] as int,
        updated: json["updated"] as int
      );
  }
}