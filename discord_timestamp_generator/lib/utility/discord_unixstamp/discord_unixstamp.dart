import 'package:discord_timestamp_generator/utility/discord_unixstamp/discord_unixstamp_style.dart';

class DiscordUnixstamp {
  int unixstamp = 0;
  DiscordUnixstampStyle style;

  DiscordUnixstamp(this.style, DateTime dateTime) {
    unixstamp = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
  }

  @override
  String toString() {
    return "<t:$unixstamp${style.discriminator}>";
  }
}
