import 'package:discord_timestamp_generator/utility/discord_unixstamp/discord_unixstamp_style.dart';
import 'package:discord_timestamp_generator/utility/seconds_since_epoch.dart';
import 'package:flutter/material.dart';

class DiscordUnixstamp with ChangeNotifier {
  int unixstamp = 0;
  DateTime dateTime = DateTime.now();
  DiscordUnixstampStyle style;

  DiscordUnixstamp(this.style, this.dateTime) {
    unixstamp = dateTime.secondsSinceEpoch;
  }

  void update(DateTime dateTime) {
    unixstamp = dateTime.secondsSinceEpoch;
    this.dateTime = dateTime;
    notifyListeners();
  }

  @override
  String toString() {
    return "<t:$unixstamp${style.discriminator}>";
  }
}
