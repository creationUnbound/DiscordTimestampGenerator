// Defines the timestamp style for Discord timestamps.

enum DiscordUnixstampStyle {
  defaultStyle("Default", "MMMM c, yyyy h:mm a"),
  shortTime("Short Time", "h:mm a", discriminator: ":t"),
  longTime("Long Time", "h:mm:ss a", discriminator: ":T"),
  shortDate("Short Date", "M/dd/yyyy", discriminator: ":d"),
  longDate("Long Date", "MMMM d, yyyy", discriminator: ":D"),
  shortDateTime("Short Date/Time", "MMMM d, yyyy h:mm a", discriminator: ":f"),
  longDateTime("Long Date/Time", "EEEE, MMMM d, yyyy h:mm a",
      discriminator: ":F"),
  relativeTime("Relative Time", "'PLACEHOLDER'", discriminator: ":R");

  final String label;
  final String discriminator;
  final String format;
  const DiscordUnixstampStyle(this.label, this.format,
      {this.discriminator = ""});
}
