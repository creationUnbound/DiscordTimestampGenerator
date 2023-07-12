// Defines the timestamp style for Discord timestamps.
enum DiscordUnixstampStyle {
  defaultStyle("Default"),
  shortTime("Short Time", discriminator: ":t"),
  longTime("Long Time", discriminator: ":T"),
  shortDate("Short Date", discriminator: ":d"),
  longDate("Long Date", discriminator: ":D"),
  shortDateTime("Short Date/Time", discriminator: ":f"),
  longDateTime("Long Date/Time", discriminator: ":F"),
  relativeTime("Relative Time", discriminator: ":R");

  final String label;
  final String discriminator;
  const DiscordUnixstampStyle(this.label, {this.discriminator = ""});
}