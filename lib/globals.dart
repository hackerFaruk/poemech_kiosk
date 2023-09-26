// this file includes global variables , import to lib and use globals.var

String lang = '';

String selected = '';

bool isEmergencyButton = false;

String firstButton = "";

String secondButton = "";

String deviceId = "";

bool renderTrigger = true;

//QR ve dolum işlemleri

int SPF30 = 0;
int SPF50 = 0;
int SPF50C = 0;
int Kopuk = 0;
int Kopek = 0;
int Dezenfektan = 0;
int wrongone = 0;

//IStimerActive
bool isTimerActive = false;

//bu üçlü proces ekranındaki hatayı süzelten mutant app icon için
// direkt pathlar
String isDualIconMemo = "";
String firstIconMemo = "";
String secondIcon = "";

//eğer wheelchairrowda seçim yapılırsa bunları kaydetmek lazım
String lengthselected = "0";
String warmthselected = "0";
String pressselected = "0";

// eğer wheelchair ekranının seçim rowu ise
bool isWheelChairBeingSelected = false;

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
  secondButton = "";

  isDualIconMemo = "";
  secondIcon = "";
  firstIconMemo = "";

  lengthselected = "0";
  warmthselected = "0";
  pressselected = "0";

  isWheelChairBeingSelected = false;
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

// ungrays all
void unGrayAll() {
  but1 = 0;
  but2 = 0;
  but3 = 0;
  but4 = 0;
  but5 = 0;
  but6 = 0;
  but7 = 0;
  but8 = 0;
  but9 = 0;
}

// i dont know why but it works, it allows you to make a selection after showwe

void grayRest(int butno) {
  but1 = 1;
  but2 = 1;
  but3 = 1;
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

void timeSet() {
  selectedTime = 10;
  if (selected.contains('spf')) {
    selectedTime = selectedTime + 5;
  } else if (selected.contains('showerLong')) {
    selectedTime = 500;
  } else if (selected.contains('showerNormal')) {
    selectedTime = 120;
  } else if (selected.contains('ShowerQuick')) {
    selectedTime = 45;
  } else if (selected.contains('dog')) {
    selectedTime = 100;
  } else if (selected.contains('bronz')) {
    selectedTime = 30;
  } else if (selected.contains('moist')) {
    selectedTime = 20;
  }

  if (selected.contains('dusty')) {
    selectedTime = selectedTime + 20;
  } else if (selected.contains('dirty')) {
    selectedTime = selectedTime + 30;
  } else if (selected.contains('grimy')) {
    selectedTime = selectedTime + 40;
  }
  if (selected.contains('furShort')) {
    selectedTime = selectedTime + 20;
  } else if (selected.contains('furMid')) {
    selectedTime = selectedTime + 40;
  } else if (selected.contains('furLong')) {
    selectedTime = selectedTime + 80;
  } else if (selected.contains('furLayered')) {
    selectedTime = selectedTime + 160;
  }
}

bool isSelectionEmpty(List<dynamic> a) {
  for (var i = 0; i < a.length; i++) {
    if (a[i] == '') {
      return true;
    }
  }
  return false;
}

// incase of secon selection remembers the first one
int rememberFirst() {
  if (but1 == 0) {
    return 1;
  } else if (but2 == 0) {
    return 2;
  } else if (but3 == 0) {
    return 3;
  } else if (but4 == 0) {
    return 4;
  } else if (but5 == 0) {
    return 5;
  } else if (but6 == 0) {
    return 6;
  } else if (but7 == 0) {
    return 7;
  } else if (but8 == 0) {
    return 8;
  } else if (but9 == 0) {
    return 9;
  } else {
    return 0;
  }
}

bool isShower() {
  if (selected.contains("shower")) {
    return true;
  } else {
    return false;
  }
}

bool isThereMissingWheelChairSelection() {
  if (warmthselected == "0") {
    return true;
  } else if (lengthselected == "0") {
    return true;
  } else if (pressselected == "0") {
    return true;
  } else {
    return false;
  }
}
