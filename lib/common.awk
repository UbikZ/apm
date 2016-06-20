#!/usr/bin/awk -f

function usage() {
  print "usage: apm [--list]";
  print "";
  print "  -l, --list         List of all dependencies.";
  print "  -v, --version      Print the current version.";
  print "  -h, --help         Print the usage message.";
  print "";
  exit;
}

function apm() {
  if (ARGC == 1 || (ARGC == 2 && ARGV[1] ~ "^(--help|-h)$")) {
    usage();
  } else {
    handleParameters();
  }
}

function handleParameters() {
  for(i = 1; i < ARGC; i++) {
    arg = ARGV[i];
    if (arg ~ "^(--list|-l)$") {
      ARGV[i] = "";
      initLoadModule();
    }
  }
}
