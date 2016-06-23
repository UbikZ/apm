#!/usr/bin/awk -f

# Main command parameters handler
function upm() {
  if (ARGC == 1) {
    usage();
  } else {
    for (i = 1; i < ARGC; i++) {
      argument = ARGV[i];
      # Options
      if (argument ~ "^(-v|--version)$") {
        print(version);
        exit;
      } else if (argument ~ "^(-V|--verbose)$") {
        verbose = 1;
      } else if (argument ~ "^(-h|--help)?$"){
        usage();
      }
      # Commands
      else if (argument == "check") {
        verbose = 1;
        checkConfiguration();
        checkExecs();
        exit;
      } else if (argument == "init") {
        # todo
      }
      # If there is some trouble with the command/options
      else {
        printf("\nCommand \"%s\" is not defined.\n", argument);
        usage();
      }
    }
  }

  exit;
}

# Print the usage
function usage() {
  print("\nUsage: upm <options> <command>\n");
  print("Where <options> are :");
  print("   -v, --version   Display the upm version.");
  print("   -V, --verbose   Enable the verbose mode.");
  print("   -h, --help      Display usage.")
  print("\nWhere <command> is one of :");
  print("   check, init, install, list, saarch, uninstall, version\n");

  exit;
}

# Execute system command execution
function exec(command) {
  command | getline result;
  return result;
}

# Check if command exists
function existsCommand(command) {
  cmd = sprintf("[[ ! `hash %s >/dev/null 2>&1 | wc -l` -eq 0 ]] && echo 0 || echo 1", command);
  return exec(cmd);
}
