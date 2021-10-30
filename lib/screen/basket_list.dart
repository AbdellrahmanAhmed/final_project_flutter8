import 'package:shared_preferences/shared_preferences.dart';

class Products_Basket {
  var id;
  String name;
  String title;
  String description;
  var price;
  var discount;
  String currency;
  String avatar;
  var priceFinal;

  Products_Basket({
    this.id,
    this.name,
    this.title,
    this.description,
    this.price,
    this.discount,
    this.currency,
    this.avatar,
    this.priceFinal,
  });
}


class PreferencesService {
  get products_basket => PreferencesService;

  Future saveSettings(Products_Basket products_basket) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setString(
        '{$products_basket.id}title', products_basket.title);
    await preferences.setString(
        '{$products_basket.id}description', products_basket.description);
    await preferences.setString(
        '{$products_basket.id}currency', products_basket.currency);
    await preferences.setString(
        '{$products_basket.id}avatar', products_basket.avatar);
    await preferences.setString(
        '{$products_basket.id}name', products_basket.name);
    await preferences.setString(
        '{$products_basket.id}priceFinal', products_basket.priceFinal);
    await preferences.setString(
        '{$products_basket.id}price', products_basket.price);
    await preferences.setString(
        '{$products_basket.id}discount', products_basket.discount);

    print('Saved settings');
  }

  Future<Products_Basket> getProducts() async {
    final preferences = await SharedPreferences.getInstance();

    final title = preferences.getString('{$products_basket.id}title');
    final description =
    preferences.getString('{$products_basket.id}description');
    final currency = preferences.getString('{$products_basket.id}currency');
    final avatar = preferences.getString('{$products_basket.id}avatar');
    final name = preferences.getString('{$products_basket.id}name');
    final priceFinal = preferences.getString('{$products_basket.id}priceFinal');
    final price = preferences.getString('{$products_basket.id}price');
    final discount = preferences.getString('{$products_basket.id}discount');

    return Products_Basket(
      title: title,
      priceFinal: priceFinal,
      price: price,
      discount: discount,
      description: description,
      currency: currency,
      avatar: avatar,
      name: name,
    );
  }
}
