#!/usr/bin/awk -f

# Main command parameters handler
function upm() {
  if (ARGC == 1) {
    usage();
  } else {
    for(i = 1; i < ARGC; i++) {
      argument = ARGV[i];
      if (argument ~ "^(-l|--list)$") {
        ARGV[i] = "";
        #todo
      } else if (argument ~ "^(-v|--version)$") {
        ARGV[i] = "";
        print(version);
      } else {
        if (argument !~ "^(-h|--help)$") {
          printf("Command \"%s\" is not defined.\n\n", argument);
        }
        usage();
      }
    }
  }

  exit;
}

# Print the usage
function usage() {
  print("usage: upm [--list]\n");
  print("  -l, --list         List of all dependencies.");
  print("  -v, --version      Print the current version.");
  print("  -h, --help         Print the usage message.");
  print("  -g, --global       Install dependencies globally.\n");
  exit;
}
