import 'package:flutter/foundation.dart';

/// App-wide cart and favourites, shared by the home and details screens.
class Shop {
  Shop._();

  static final cartCount = ValueNotifier<int>(0);
  static final favourites = ValueNotifier<Set<String>>({});

  static void addToCart([int quantity = 1]) => cartCount.value += quantity;

  static bool isFavourite(String id) => favourites.value.contains(id);

  static void toggleFavourite(String id) {
    final next = {...favourites.value};
    if (!next.remove(id)) next.add(id);
    favourites.value = next;
  }
}
