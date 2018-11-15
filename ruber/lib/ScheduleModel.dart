import 'dart:convert';
import 'ProfileModel.dart';


Schedule scheduleFromJson(String str) {
  final jsonData = json.decode(str);
  return Schedule.fromJson(jsonData);
}

String scheduleToJson(Schedule data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

List<Schedule> allSchedulesFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<Schedule>.from(jsonData.map((x) => Schedule.fromJson(x)));
}

String allScheduleToJson(List<Schedule> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class Schedule {
  Post profile;
  Day day;
  var goingToRangeStart;
  var goingToRangeEnd;
  var leavingRangeStart;
  var leavingRangeEnd;

  Schedule({
    this.profile,
    this.day,
    this.goingToRangeStart,
    this.goingToRangeEnd,
    this.leavingRangeStart,
    this.leavingRangeEnd,
  });


  factory Schedule.fromJson(Map<String, dynamic> parsedJson) {
    return Schedule(
      profile: parsedJson["profile"],
      day: parsedJson["day"],
      goingToRangeStart: parsedJson["goingToRangeStart"],
      goingToRangeEnd: parsedJson["goingToRangeEnd"],
      leavingRangeStart: parsedJson["leavingRangeStart"],
      leavingRangeEnd: parsedJson["leavingRangeEnd"],
    );}

  Map<String, dynamic> toJson() =>
      {
        "profile": profile,
        "day": day,
        "goingToRangeStart": goingToRangeStart,
        "goingToRangeEnd": goingToRangeEnd,
        "leavingRangeStart": leavingRangeStart,
        "leavingRangeEnd": leavingRangeEnd,
      };

}
class Day{

}
