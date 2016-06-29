#!/usr/bin/awk -f

function init() {
  exec("touch", packageFile);
}
