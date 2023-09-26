// Defines the timestamp style for Discord timestamps.

enum DiscordUnixstampStyle {
  defaultStyle("Default", "MMMM c, yyyy h:mm a", "c MMMM yyyy H:mm"),
  shortTime("Short Time", "h:mm a", "H:mm", discriminator: ":t"),
  longTime("Long Time", "h:mm:ss a", "H:mm:ss", discriminator: ":T"),
  shortDate("Short Date", "M/dd/yyyy", "dd/M/yyyy", discriminator: ":d"),
  longDate("Long Date", "MMMM d, yyyy", "d MMMM yyyy", discriminator: ":D"),
  shortDateTime("Short Date/Time", "MMMM d, yyyy h:mm a", "d MMMM yyyy H:mm", discriminator: ":f"),
  longDateTime("Long Date/Time", "EEEE, MMMM d, yyyy h:mm a", "EEEE, d MMMM yyyy H:mm",
      discriminator: ":F"),
  relativeTime("Relative Time", "'PLACEHOLDER'", "'PLACEHOLDER'", discriminator: ":R");

  final String label;
  final String format12Hr;
  final String format24Hr;
  final String discriminator;
  const DiscordUnixstampStyle(this.label, this.format12Hr, this.format24Hr,
      {this.discriminator = ""});
}
