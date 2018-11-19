import 'dart:convert';


String newScheduleToJson(NewSchedule data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class NewSchedule {
  int id;
  int profile;
  String day;
  String goingToRangeStart;
  String goingToRangeEnd;
  String leavingRangeStart;
  String leavingRangeEnd;



  NewSchedule({
    this.id,
    this.profile,
    this.day,
    this.goingToRangeStart,
    this.goingToRangeEnd,
    this.leavingRangeStart,
    this.leavingRangeEnd,

  });

  factory NewSchedule.fromJson(Map<String, dynamic> parsedJson) {
    return NewSchedule(
      id: parsedJson["id"],
      profile: parsedJson["profile"],
      day: parsedJson["day"],
      goingToRangeStart: parsedJson["goingToRangeStart"],
      goingToRangeEnd: parsedJson["goingToRangeEnd"],
      leavingRangeStart: parsedJson["leavingRangeStart"],
      leavingRangeEnd: parsedJson["leavingRangeEnd"],
    );}

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "profile": profile,
        "day": day,
        "goingToRangeStart": goingToRangeStart,
        "goingToRangeEnd": goingToRangeEnd,
        "leavingRangeStart": leavingRangeStart,
        "leavingRangeEnd": leavingRangeEnd,
      };
}