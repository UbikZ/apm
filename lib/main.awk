#!/usr/bin/awk -f

function include(includeFile) {
  includes[includeFile]
}

function sourceIncludes() {
  if (!loaded) {
    scriptname="/usr/bin/awk -f ./lib/main.awk";
    for (file in includes) {
      includeString = includeString " -f "file;
    }
    system(sprintf("%s %s -v loaded=1\n", scriptname, includeString));
    exit;
  }
}

BEGIN {
  include("./lib/common.awk");
  sourceIncludes();

  usage();
}

function usage() {
  if (ARGC == 1 || (ARGC==2 && ARGV[1]== "-h")) {
    print "usage: apm [--list]";
    print "";
    print "  --list     List of all dependencies.";
    print "";
    exit
  }
}
