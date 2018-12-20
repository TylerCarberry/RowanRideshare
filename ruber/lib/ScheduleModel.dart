import 'dart:convert';

//Takes in a JSON string and converts it to a NewUser object
Schedule scheduleFromJson(String str) {
  final jsonData = json.decode(str);
  return Schedule.fromJson(jsonData);
}

//Takes in a Schedule object and returns a JSON String
String scheduleToJson(Schedule data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

//Returns a list of all Schedules from a JSON String
List<Schedule> allSchedulesFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<Schedule>.from(jsonData.map((x) => Schedule.fromJson(x)));
}

//Converts a List of schedules to a JSON String
String allScheduleToJson(List<Schedule> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

//Class that creates a Schedule object and allows converting and parsing the data
class Schedule {
  int id;
  int profile;
  String monday;
  String tuesday;
  String wednesday;
  String thursday;
  String friday;

  //Constructor for Schedule has id, profile, and days of the week
  Schedule({
    this.id,
    this.profile,
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
  });

  //Converts the JSON to a NewUser
  factory Schedule.fromJson(Map<String, dynamic> parsedJson) {
    return Schedule(
      id: parsedJson["id"],
      profile: parsedJson["profile"],
      monday: parsedJson["monday"],
      tuesday: parsedJson["tuesday"],
      wednesday: parsedJson["wednesday"],
      thursday: parsedJson["thursday"],
      friday: parsedJson["friday"],
    );
  }

  //Converts the data to JSON
  Map<String, dynamic> toJson() => {
    "id": id,
    "profile": profile,
    "monday": monday,
    "tuesday": tuesday,
    "wednesday": wednesday,
    "thursday": thursday,
    "friday": friday
  };
}