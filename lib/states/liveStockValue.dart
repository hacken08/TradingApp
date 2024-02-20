import 'dart:ffi';

import 'dart:math';

Map<String, dynamic> liveData(double interval) {
  Random random = Random();
  double basePrice = 234.24;
  double price = basePrice + (random.nextDouble() - 0.5) * interval;
  double open = basePrice + (random.nextDouble() - 0.5) * interval;
  double high = basePrice + (random.nextDouble() - 0.5) * interval;
  double low = basePrice + (random.nextDouble() - 0.5) * interval;
  double close = basePrice + (random.nextDouble() - 0.5) * interval;

  price = price.clamp(0, double.infinity);
  open = open.clamp(0, double.infinity);
  high = high.clamp(0, double.infinity);
  low = low.clamp(0, double.infinity);
  close = close.clamp(0, double.infinity);

  Map<String, dynamic> output = {
    'price': price.toStringAsFixed(2),
    'open': open.toStringAsFixed(2),
    'high': high.toStringAsFixed(2),
    'low': low.toStringAsFixed(2),
    'close': close.toStringAsFixed(2),
  };

  return output;
}
