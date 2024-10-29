extension MyIntExtensions on int {
  String formatInt() {
    if (this == 0) {
      return '00';
    } else {
      return '$this';
    }
  }
}
