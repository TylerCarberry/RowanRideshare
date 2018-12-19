import 'dart:convert';

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
  int id;
  int profile;
  String monday;
  String tuesday;
  String wednesday;
  String thursday;
  String friday;

  Schedule({
    this.id,
    this.profile,
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
  });

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
