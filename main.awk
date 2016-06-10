#!/usr/bin/awk -f

function include(includeFile) {
    includes[includeFile]
}

function sourceIncludes() {
    if (!loaded) {
        scriptname="/usr/bin/awk -f main.awk";
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
}

{
    test();
}
