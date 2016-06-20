#!/usr/bin/awk -f

function usage() {
  print "usage: apm [--list]";
  print "";
  print "  --list     List of all dependencies.";
  print "";
  exit;
}

function apm() {
  if (ARGC == 1 || (ARGC == 2 && ARGV[1] == "-h")) {
    usage();
  } else {
    handleParameters();
  }
}

function handleParameters() {
  for(i = 1; i < ARGC; i++) {
    arg = ARGV[i];
    if (arg == "--list") {
      ARGV[i] = "";
      initLoadModule();
    }
  }
}
