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
      } else if (argument ~ "^(-v|--version)$") {
        ARGV[i] = "";
        print(version);
      } else if (argument ~ "^(-c|--check)$") {
        ARGV[i] = "";
        checkConfiguration();
        checkExecs();
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
  print("usage: upm [--list]");
  print("  -l, --list         List of all dependencies.");
  print("  -v, --version      Print the current version.");
  print("  -g, --global       Install dependencies globally.");
  print("  -c, --check        Check upm right configuration.");
  print("  -h, --help         Print the usage message.");

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
