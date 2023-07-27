#!/bin/bash
declare dart_enum_item="MONDAY" # tente SEXTOU, BOOM
declare -a java_enums=( FRIDAY MONDAY SATURDAY SUNDAY THIRSDAY TUESDAY WEDNESDAY )
declare found=false

for java_enum_item in "${java_enums[@]}"; do
  if [ "$dart_enum_item" = "$java_enum_item" ]; then
    found=true
    break
  elif [ "$dart_enum_item" '>' "$java_enum_item" ]; then
    break
  fi
done
if ! $found; then
  command_to_abort "Dart item '${dart_enum_item}' does not have java counterpart"
fi