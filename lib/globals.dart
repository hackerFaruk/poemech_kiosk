// this file includes global variables , import to lib and use globals.var

String lang = '';

String selected = '';

/// required for grayablenine widget
List<int> butArr = [0, 0, 0, 0, 0, 0, 0, 0, 0];
List<int> isButtonSelected = [0, 0, 0, 0, 0, 0, 0, 0, 0];
List<int> allOpen = List.unmodifiable([0, 0, 0, 0, 0, 0, 0, 0, 0]);
List<int> allGray = List.unmodifiable([1, 1, 1, 1, 1, 1, 1, 1, 1]);

// list.unmodifiable makes list immutable so you wont change those by accident

int but1 = 0;
int but2 = 0;
int but3 = 0;
int but4 = 0;
int but5 = 0;
int but6 = 0;
int but7 = 0;
int but8 = 0;
int but9 = 0;

int isBut1Selected = 0;
int isBut2Selected = 0;
int isBut3Selected = 0;
int isBut4Selected = 0;
int isBut5Selected = 0;
int isBut6Selected = 0;
int isBut7Selected = 0;
int isBut8Selected = 0;
int isBut9Selected = 0;

void revertAll() {
  but1 = 0;
  but2 = 0;
  but3 = 0;
  but4 = 0;
  but5 = 0;
  but6 = 0;
  but7 = 0;
  but8 = 0;
  but9 = 0;

  isBut1Selected = 0;
  isBut2Selected = 0;
  isBut3Selected = 0;
  isBut4Selected = 0;
  isBut5Selected = 0;
  isBut6Selected = 0;
  isBut7Selected = 0;
  isBut8Selected = 0;
  isBut9Selected = 0;
}

void grayAll() {
  but1 = 1;
  but2 = 1;
  but3 = 1;
  but4 = 1;
  but5 = 1;
  but6 = 1;
  but7 = 1;
  but8 = 1;
  but9 = 1;
}
