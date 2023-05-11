# cococara_crm_mobile

A CRM app for Cococara

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

## Commands

### Generate Icons
>flutter pub run flutter_launcher_icons:main

### Generate JSON boilerplate code
>flutter pub run build_runner build --delete-conflicting-outputs


### Start a watcher to generate JSON code
>flutter pub run build_runner watch


### Using Gradle's Signing Report
You can also get the SHA-1 of your signing certificate using the Gradle signingReport command:

cd android/

./gradlew signingReport


### Disable logs
>python3 comment_print_statements.py -d -t ./lib

### Enable Logs
>python3 comment_print_statements.py -e -t ./lib



## IOS Setup
> Add URL schema for com.googleusecontent.app..... using XCode


## Erro Resolution
>EXCEPTION IN LOGIN PlatformException(google_sign_in, Your app is missing support for the following URL schemes: com.googleusercontent.apps.761432135665-dl38e8a8g6bamamddv51hn123n6na6dl, NSInvalidArgumentException, null)
flutter: Login failure Error while trying to login PlatformException(google_sign_in, Your app is missing support for the following URL schemes: com.googleusercontent.apps.761432135665-dl38e8a8g6bamamddv51hn123n6na6dl, NSInvalidArgumentException, null)
>

## Build for realease
### Android
cd [project]
flutter build apk --split-per-abi



## to Insatall on Local device
flutter build apk --debug
flutter install