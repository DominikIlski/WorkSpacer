# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.0.1] - 2022-05-18

### Added 
* Backend template (strapi)
* App template (flutter)

## [0.1.0] - 2022-05-23

### Added
* Created all the screens without content, with navigation.
* Prepared the models.
* Created a KeyboardHideWrapper. Use it to wrap a screen that has a textfield inside. Now if you click outside, the textfield will no longer stay focused.

### Changed
* SDK version changed from 2.16.1 to 2.17.0 in order to use new syntax for super constructors.

## [0.2.0]  - 2022-06-01

### Added
* Components package in each of implemented screens which containts Custom Widgets used in those screens
* Home Screen button widget which is a basic UI element of home screens (both for Employee and Admin)
* ReservationListItem Widget in admin/cancel package, which is a basic list item for Reservation in CancelReservationScreen
* Implemented UI for CancelReservationScreen based on Figma mockip - added search (with no functionality yet) TextField and ReservationsList with implementation of cancelling  them - Cancel button invokes confirmation dialog which when confirmed deletes reservation from list
* Installed intl package which provied DateFromat utilities

### Changed 
* Adjusted RoomReservation model class to be equivalent to teh DeskReservation class (extends Reservation with proper super calls in constructor)
* Adjusted ThemeData in app.dart - added colors equivalent to the color palette from Figma mockups
* Changed UI of home screens to match mockups
