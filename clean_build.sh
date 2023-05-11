#!/bin/bash
set -e
if [ -z "$1" ]
then
  perl -i -pe 's/^(version:\s+\d+\.\d+\.)(\d+)(\+)(\d+)$/$1.($2+1).$3.($4+1)/e' pubspec.yaml
else
  sed -i '' "s/^version.*/version: $1/g" pubspec.yaml
fi

python3 comment_print_statements.py -d -t ./lib
flutter clean
flutter pub get
# flutter build ios
cd ios
pod install
cd ..
flutter build appbundle
# python3 comment_print_statements.py -e -t ./lib