class Formatter {
  static String captalize({required String text}) {
    int textLength = text.length;
    String copy = '';
    bool captalize = false;

    copy += text[0].toUpperCase();

    for (int i = 1; i < textLength; i++) {
      if (text[i] == ' ') {
        captalize = true;
        copy += text[i];
        continue;
      }

      if (captalize) {
        copy += text[i].toUpperCase();
        captalize = false;
      } else {
        copy += text[i].toLowerCase();
      }
    }

    return copy;
  }
}
