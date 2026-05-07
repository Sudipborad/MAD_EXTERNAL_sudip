class Calculations {
  static int calculateProportionalValue(int baseValue, int baseQuantity, int currentQuantity) {
    if (baseQuantity == 0) return 0;
    return ((baseValue / baseQuantity) * currentQuantity).round();
  }
}
