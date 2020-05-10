#!/usr/bin/env bash
cd ..
rm -rf coverage || return
file=test/coverage_helper_test.dart
rm $file
package=$(printf "%s" "$(<pubspec.yaml)" | grep name: | cut -c7-)
printf "// Helper file to make coverage work for all dart files\n" >> $file
printf "//ignore_for_file: unused_import" >> $file
find lib -name '*.dart' | cut -c4- | awk -v package="$package" '{printf "import '\''package:%s%s'\'';\n",
package, $1}' >> $file
printf "\nvoid main(){}" >> $file

flutter test --coverage
genhtml coverage/lcov.info  -o coverage --no-function-coverage -s  --highlight --legend --missed
open coverage/index.html
rm $file
exit 0
