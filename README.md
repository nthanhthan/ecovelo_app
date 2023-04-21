
ECOVELO Project
A ECOVELO project created in flutter, supports both iOS and Android.
Design: https://www.figma.com/file/Z3ehKAErU313zoBOFdnXzH/EcoVelo-Design-File?node-id=83-28387&t=FydEDsxCIKUp2ELd-0

Getting Started
Setup Enviroment:
Flutter SDK ver 3.0.5 • channel stable • https://github.com/flutter/flutter.git
Dart ver 2.17.6
Dev Tools ver 2.12.2

How to Use
Step 1:
Download or clone this repo by using the link below:

https://github.com/nthanhthan/ecovelo_app.git


Step 2:
Go to project root and execute the following command in console to get the required dependencies:

flutter pub get 

Step 3:
This project uses inject library that works with code generation, execute the following command to generate files:

flutter packages pub run build_runner build --delete-conflicting-outputs


or watch command in order to keep the source code synced automatically:

flutter packages pub run build_runner watch


Step 5:
To run project

Use command line

flutter run --release 



Libraries & Tools Used


Dio (HTTP Client)

Hive (Database)

GetX (State Management)


Folder Structure
Here is the core folder structure which flutter provides.

ecovelo-app/
|-  android
|-  assets
|   |- fonts                => Fonts
|   |- icons                => App icon files
|   |- images               => Image files (SVG, PNG, JPG)
|   |- jsons               => json files
|-  build
|-  ios
|-  lib                     => App src
|-  test
|-  pubspec.yaml
|-  analysis_options.yaml   => This file configures the analyzer, which statically analyzes Dart code to check for errors, warnings, and lints.


Here is the folder structure we have been using in this project

lib/
|-  app/
|   |-  congfig/        => Contains routes, themes, build config
|   |-  constants/      => All the application level constants are defined in this directory 
|   |-  hive-manager/   => Contains hive manager, key models
|   |-  pages/          => Contains all the business logic of a screen
|       |-  login/      => exp: login page
|           |-  bindings/
|           |-  controllers/
|           |-  repositories/
|           |-  services/
|           |-  views/
|           |-  login.dart
|   |-  utils/          => Contains utils
|   |-  widgets/        => Contains the common widgets that are shared across multiple screens
|   |-  core.dart
|-  common/             => Contains the common file(s) and utilities used in a project
|-  generated/          => Generated files
|-  l10n/               => Text files
|-  main.dart           => Run app
