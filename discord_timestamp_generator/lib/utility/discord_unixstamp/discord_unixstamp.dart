import 'package:discord_timestamp_generator/utility/discord_unixstamp/discord_unixstamp_style.dart';
import 'package:discord_timestamp_generator/utility/seconds_since_epoch.dart';

class DiscordUnixstamp {
  int unixstamp = 0;
  DiscordUnixstampStyle style;

  DiscordUnixstamp(this.style, DateTime dateTime) {
    unixstamp = dateTime.secondsSinceEpoch;
  }

  void update(DateTime dateTime) {
    unixstamp = dateTime.secondsSinceEpoch;
  }

  @override
  String toString() {
    return "<t:$unixstamp${style.discriminator}>";
  }
}
