import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  Map myCart = {};

  addToCart(String name, int price) {
    myCart[name] = price;

    notifyListeners();
  }

  removeFromCart(String name, int price) {
    myCart.remove(name);
    notifyListeners();
  }
}
