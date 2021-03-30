# Badfood (DSC Solution Challenge 2021)

![Flutter](https://img.shields.io/badge/Dart-Flutter-02569B?logo=Flutter)
![Laravel](https://img.shields.io/badge/php-Laravel-FF2D20?logo=Laravel)
![MySQL](https://img.shields.io/badge/db-MySQL-orange?logo=MySQL)
![Docker](https://img.shields.io/badge/container-Docker-2496ED?logo=Docker)
![Firebase](https://img.shields.io/badge/with-Firebase-FFCC00?logo=Firebase)
![GCP](https://img.shields.io/badge/with-Google%20Cloud%20Platform-4285F4?logo=Google%20Cloud)
![GoogleMaps](https://img.shields.io/badge/with-Google%20Map-red?logo=Google%20Maps)

A bad food report app.

We want to solve the food safety problem from the bad food you eat.

As a cross-platform application, we hope users can report the bad food as soon as possible, and build a better eating environment.

## Screenshots

<img src="https://github.com/wst24365888/badfood/blob/main/screenshots/screenshot-1.png" width="25%">
<img src="https://github.com/wst24365888/badfood/blob/main/screenshots/screenshot-2.png" width="25%">
<img src="https://github.com/wst24365888/badfood/blob/main/screenshots/screenshot-3.png" width="25%">
<img src="https://github.com/wst24365888/badfood/blob/main/screenshots/screenshot-4.png" width="25%">

## About this project

This project is made by DSC NCU(National Central University) for DSC Solution Challenge 2021.

For more information, you can check our demo video.

## Usage

### Install

``` bash
git clone https://github.com/wst24365888/badfood.git
```

### Build

> Remember to setup your Flutter environment first.

``` bash
flutter pub get
flutter run
```

## Use Stacks

- Flutter
- Firebase Authentication
- Firebase Storage
- GCP Compute Engine
- GCP Cloud SQL
- Google Map API
- Laravel
- Docker
- Mysql

## Contributor

- [Xyphuz Wu](https://github.com/wst24365888)
- [Yihong Lin](https://github.com/uccuz)
- [ChunPing Chung](https://github.com/hope51607)
- [Jeanshan Chou](https://github.com/kn71026)

## License

[MIT License](https://choosealicense.com/licenses/mit/)

## Changelogs

### ver-1.0.0

- Officially release.

### ver-0.6.2-prerelease

- Fix the bug that caused some of the store pages doesn't show any result.

- Fix the bug that caused text overflow in some of the detailed report pages.

### ver-0.6.1-prerelease

- Adjust auth page UI.

### ver-0.6.0-prerelease

- Add icon.

- Redesign auth page UI.

### ver-0.5.5

- Fix the bug that caused double tap (zoom in) gesture registered on whole map page.

- Adjust map markers to immutable.

### ver-0.5.4

- Fix the bug that caused CORS problem during loading time of detailed report page.

### ver-0.5.3

- Adjust marker position of map page.

### ver-0.5.2

- Reverse result of store page, user can take a look at the newest report right now.

### ver-0.5.1

- Rename: PersonPage => ProfilePage.

### ver-0.5.0

- Add detailed report page.

### ver-0.4.6

- Fix the bug that caused store page can't see any reports.

### ver-0.4.5

- Adjust StorePage's list size.

### ver-0.4.4

- Fix the bug when a user denies the permission to access location.

### ver-0.4.3

- Fix the bug that caused the loading location to be very slow.

### ver-0.4.2

- Fix the render problem for the web version of person page.
Change the place prediction display type from place name to place name + address.

### ver-0.4.1

- Fix some bug of deserialization.
Adjust dropdown menu's size in store page.

### ver-0.4.0

- Fix the bug that caused the report submission to fail.
Change the place prediction display type from address to place name.

### ver-0.3.2-prerelease

- Fix domain bugs.

### ver-0.3.1-prerelease

- Add a certificate to backend.

### ver-0.3.0-prerelease

- Backend available now. Ready to release.

### ver-0.2.2

- Fix Android http connection issue.

### ver-0.2.1

- Finish web version, but auth page UI/report page UI/store page UI is not unique tho.

### ver-0.2.0

- Finish web version(dirty).

### ver-0.1.3

- Add support page.

### ver-0.1.2

- New feature: loading indicator.

### ver-0.1.1

- Modify report history page to date-descending.

### ver-0.1.0

- Android version & mobile size of web version finished.
