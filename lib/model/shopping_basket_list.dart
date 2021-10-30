import 'package:flutter/material.dart';


class ShoppingBasket {
  ShoppingBasket(
      {@required this.title,
      this.name,
      this.avatar,
      this.description,
      this.discount,
      this.inStock,
      this.price,
      this.priceFinal,
      this.currency,
      this.quantity});

  String title;
  String name;
  String description;
  int price;
  int discount;
  String avatar;
  int inStock;
  int priceFinal;
  int currency;
  int quantity;
}
