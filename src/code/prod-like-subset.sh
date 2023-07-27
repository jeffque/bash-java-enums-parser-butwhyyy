local -a java_enums=( `extract-enum MyEnum.java | sort` )
local dart_enum_item
local found

for dart_enum_item in `extract-enum MyEnum.dart`; do
  found=false
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
done