#!/usr/bin/awk -f
#
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

# Execute properly simple command
# - If there is something one the stderr : exit code
function properExec(command, arguments, message) {
  result = exec(command, arguments);
  if (result == 0) {
    print(message);
    if (verbose == 1) {

    }
    exit;
  }
  return result;
}

# Function to execute only known system commands
function exec(command, arguments) {
  if (cmds[command] != "") {
    return __exec(cmds[command] " " arguments);
  } else {
    if (verbose == 1) {
      printf("Command '%s' not indexed.\n", command);
    }
    exit;
  }
}

# Generic function to execute system commands
function __exec(command) {
  command | getline result;
  return result;
}

# Check if command exists
function existsCommand(command) {
  cmd = sprintf("[[ ! `hash %s >/dev/null 2>&1 | wc -l` -eq 0 ]] && echo 0 || echo 1", command);
  return __exec(cmd);
}
