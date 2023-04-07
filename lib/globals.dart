// this file includes global variables , import to lib and use globals.var

String lang = '';

String selected = '';

String firstButton = "";

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

/// It resets all the variables to their original state
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

  selected = "";
  firstButton = "";
}

/// This function sets all the buttons to gray.
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

/// It takes an integer as an argument and sets the corresponding isButXSelected variable to 1
///
/// Args:
///   selection (int): The button number that you want to select.
void setSelected(int selection) {
  switch (selection) {
    case 1:
      {
        isBut1Selected = 1;
      }
      break;

    case 2:
      {
        isBut2Selected = 1;
      }
      break;

    case 3:
      {
        isBut3Selected = 1;
      }
      break;
    case 4:
      {
        isBut4Selected = 1;
      }
      break;
    case 5:
      {
        isBut5Selected = 1;
      }
      break;
    case 6:
      {
        isBut6Selected = 1;
      }
      break;
    case 7:
      {
        isBut7Selected = 1;
      }
      break;
    case 8:
      {
        isBut8Selected = 1;
      }
      break;
    case 9:
      {
        isBut9Selected = 1;
      }
      break;
  }
}

void setSingleActive(int selection) {
  switch (selection) {
    case 1:
      {
        but1 = 0;
      }
      break;

    case 2:
      {
        but2 = 0;
      }
      break;

    case 3:
      {
        but3 = 0;
      }
      break;
    case 4:
      {
        but4 = 0;
      }
      break;
    case 5:
      {
        but5 = 0;
      }
      break;
    case 6:
      {
        but6 = 0;
      }
      break;
    case 7:
      {
        but7 = 0;
      }
      break;
    case 8:
      {
        but8 = 0;
      }
      break;
    case 9:
      {
        but9 = 0;
      }
      break;
  }
}

int isButActive(int selection) {
  switch (selection) {
    case 1:
      {
        return but1;
      }

    case 2:
      {
        return but2;
      }

    case 3:
      {
        return but3;
      }

    case 4:
      {
        return but4;
      }

    case 5:
      {
        return but5;
      }

    case 6:
      {
        return but6;
      }

    case 7:
      {
        return but7;
      }

    case 8:
      {
        return but8;
      }

    case 9:
      {
        return but9;
      }
    default:
      {
        return 1;
      }
  }
}

int isButSelected(int selection) {
  switch (selection) {
    case 1:
      {
        return isBut1Selected;
      }

    case 2:
      {
        return isBut2Selected;
      }

    case 3:
      {
        return isBut3Selected;
      }

    case 4:
      {
        return isBut4Selected;
      }

    case 5:
      {
        return isBut5Selected;
      }

    case 6:
      {
        return isBut6Selected;
      }

    case 7:
      {
        return isBut7Selected;
      }

    case 8:
      {
        return isBut8Selected;
      }

    case 9:
      {
        return isBut9Selected;
      }
    default:
      {
        return 1;
      }
  }
}

/// If any of the nine buttons are selected, return true
///
/// Returns:
///   A boolean value.
bool isSecondSelection() {
  var sum = isBut1Selected +
      isBut2Selected +
      isBut3Selected +
      isBut4Selected +
      isBut5Selected +
      isBut6Selected +
      isBut7Selected +
      isBut8Selected +
      isBut9Selected;

  if (sum > 0) {
    return true;
  } else {
    return false;
  }
}

int selectedTime = 100;
