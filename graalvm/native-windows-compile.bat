@echo off

echo Building nrepl-graalvm-sample %NREPL_GRAALVM_SAMPLE_JAR% with Xmx of %NREPL_GRAALVM_SAMPLE_XMX%

rem the --no-server option is not supported in GraalVM Windows.
call %GRAALVM_HOME%\bin\native-image.cmd ^
      "-jar" "%NREPL_GRAALVM_SAMPLE_JAR%" ^
      "-H:+ReportExceptionStackTraces" ^
      "--verbose" ^
      "--no-fallback" ^
      "--native-image-info" ^
      "%NREPL_GRAALVM_SAMPLE_XMX%"
