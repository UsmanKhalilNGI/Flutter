import 'package:flutter/material.dart';
import '../../features/cart/Cart.dart';

class AppRouter {
  static const cart = '/cart';

  static final routes = <String, WidgetBuilder>{
    cart: (_) => const Cart(),
  };
}
