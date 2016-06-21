#!/usr/bin/awk -f


# Main command parameters handler
function upm() {
  for(i = 1; i < ARGC; i++) {
    argument = ARGV[i];
    if (argument ~ "^(-l|--list)$") {
      ARGV[i] = "";
      #todo
    } else if (argument ~ "^(-v|--version)$") {
      ARGV[i] = "";
      print(version);
    } else {
      usage();
    }
  }
  exit;
}

# Print the usage
function usage() {
  print "usage: upm [--list]";
  print "";
  print "  -l, --list         List of all dependencies.";
  print "  -v, --version      Print the current version.";
  print "  -h, --help         Print the usage message.";
  print "  -g, --global       Install dependencies globally.";
  print "";
}
