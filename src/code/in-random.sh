#!/bin/bash
declare dart_enum_item="MONDAY" # tente SEXTOU, BOOM
declare -a java_enums=( MONDAY TUESDAY WEDNESDAY THIRSDAY FRIDAY SATURDAY SUNDAY )
declare found=false

for java_enum_item in "${java_enums[@]}"; do
  if [ "$dart_enum_item" = "$java_enum_item" ]; then
    found=true
    break
  fi
done
if ! $found; then
  command_to_abort "Dart item '${dart_enum_item}' does not have java counterpart"
fi
