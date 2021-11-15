#!/usr/bin/env bash

set -e

if [ -z "$GRAALVM_HOME" ]; then
    echo "Please set GRAALVM_HOME"
    exit 1
fi

if [[ ! -f "$NREPL_GRAALVM_SAMPLE_JAR" ]]
then
    clojure -X:jar
    NREPL_GRAALVM_SAMPLE_JAR=$(ls nrepl-graalvm-sample.jar)
fi

NREPL_GRAALVM_SAMPLE_XMX=${NREPL_GRAALVM_SAMPLE_XMX:-"-J-Xmx4g"}

args=("-jar" "$NREPL_GRAALVM_SAMPLE_JAR"
      "-H:+ReportExceptionStackTraces"
      "--verbose"
      "--no-fallback"
      "--native-image-info"
      "-J-Dclojure.compiler.direct-linking=true"
      "-J-Dclojure.spec.skip-macros=true"
      "-H:-CheckToolchain"
      "--allow-incomplete-classpath"
      "--report-unsupported-elements-at-runtime"
      "$NREPL_GRAALVM_SAMPLE_XMX")

NREPL_GRAALVM_SAMPLE_STATIC=${NREPL_GRAALVM_SAMPLE_STATIC:-}

if [ "$NREPL_GRAALVM_SAMPLE_STATIC" = "true" ]; then
    args+=("--static")
fi

"$GRAALVM_HOME/bin/native-image" "${args[@]}"
