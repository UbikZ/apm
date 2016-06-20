#!/usr/bin/awk -f

function include(includeFile) {
  includes[includeFile]
}

function sourceIncludes() {
  if (!loaded) {
    scriptname="/usr/bin/awk -f ./lib/main.awk";
    for (i = 1; i < ARGC; i++) {
      args = args " "ARGV[i];
    }
    for (file in includes) {
      includeString = includeString " -f "file;
    }
    cmd = sprintf("%s %s -v loaded=1 -- %s\n", scriptname, includeString, args);
    system(cmd);
    exit;
  }
}

BEGIN {
  include("./lib/common.awk");
  include("./lib/init.awk");
  sourceIncludes();


  if (ARGC == 1 || (ARGC == 2 && ARGV[1] == "-h")) {
    usage()
  } else {
    handlePosix();
  }
}

function usage() {
  print "usage: apm [--list]";
  print "";
  print "  --list     List of all dependencies.";
  print "";
  exit
}

function handlePosix() {
  for(i = 1; i < ARGC; i++) {
    arg = ARGV[i];
    if (arg == "--list") {
      ARGV[i] = "";
      initLoadModule();
    }
  }
}
