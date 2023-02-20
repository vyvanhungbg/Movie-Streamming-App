extension StringExtension on String {
  Duration toDuration() {
    List<String> durationParts = this.split(':');

    int hours = int.parse(durationParts[0]);
    int minutes = int.parse(durationParts[1]);
    List<String> secondsParts = durationParts[2].split('.');
    int seconds = int.parse(secondsParts[0]);
    int milliseconds = int.parse(secondsParts[1].padRight(6, '0'));

    Duration duration = Duration(
      hours: hours,
      minutes: minutes,
      seconds: seconds,
      milliseconds: milliseconds,
    );
    return duration;
  }
}
