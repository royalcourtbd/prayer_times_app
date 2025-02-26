enum FastingState {
  none,
  sehri,
  fasting,
  iftar;

  String get displayName {
    switch (this) {
      case FastingState.sehri:
        return 'Sehri';
      case FastingState.fasting:
        return 'Fasting';
      case FastingState.iftar:
        return 'Iftar';
      case FastingState.none:
        return '';
    }
  }
}
