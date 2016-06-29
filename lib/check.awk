#!/usr/bin/awk -f

function checkConfiguration() {
  version = "0.0.1";
  packageFile = "upm.json";
  packageModules = "upm_modules";
  if (verbose == 1) {
    print("> Configuration :");
    printf("  • Version         : %s\n", version);
    printf("  • Verbose mode    : %s\n", verbose);
    printf("  • Package File    : %s\n", packageFile);
    printf("  • Package Modules : %s\n", packageModules);
  }
}

function checkExecs() {
  if (verbose == 1) {
    printf("> Check required installed commands.\n", command);
  }
  # Always in first place
  checkExecPath("which");
  checkExecPath("awk");
  checkExecPath("wget");
  checkExecPath("touch");
}

function checkExecPath(command) {
  if (existsCommand(command) == 1) {
    cmds[command] = command = "which" ? command : __exec(sprintf("%s %s", cmds["which"], command));
    if (verbose == 1) {
      printf("  ✔ Command '%s' is installed. Path : '%s'\n", command, cmds[command]);
    }
  } else {
    if (verbose == 1) {
      printf("  × Command '%s' is not installed.\n", command);
    } else {
      printf("Command '%s' not found. Please install it.\n", command);
    }
    exit;
  }
}
