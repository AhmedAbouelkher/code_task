///Gets the time of the days to greet the current user.
String getTimeOfTheDay(DateTime time) {
  if (time.hour >= 0 && time.hour < 6) return TimeOfDay.night;
  if (time.hour >= 6 && time.hour < 12) return TimeOfDay.morning;
  if (time.hour >= 12 && time.hour < 18) return TimeOfDay.afternoon;
  return TimeOfDay.evening;
}

///Represents the times of one day. ex: Afternoon
class TimeOfDay {
  static const morning = "Morning";
  static const night = "Night";
  static const evening = "Evening";
  static const afternoon = "Afternoon";
}
