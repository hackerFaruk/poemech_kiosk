// this file includes global variables , import to lib and use globals.var

String lang = '';

String selected = '';

/// required for grayablenine widget
List<int> butArr = [0, 0, 0, 0, 0, 0, 0, 0, 0];
List<int> isButtonSelected = [0, 0, 0, 0, 0, 0, 0, 0, 0];
List<int> allOpen = List.unmodifiable([0, 0, 0, 0, 0, 0, 0, 0, 0]);
List<int> allGray = List.unmodifiable([1, 1, 1, 1, 1, 1, 1, 1, 1]);

// list.unmodifiable makes list immutable so you wont change those by accident
