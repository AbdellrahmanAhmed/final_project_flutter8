
import 'package:flutter/material.dart';

import 'basket_list.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState(Products_Basket());
}

class _MyHomePageState extends State<MyHomePage> {
  final Products_Basket products_Basket;

  _MyHomePageState(this.products_Basket);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productFields();
  }

  final _preferencesService = PreferencesService();
  String title;
  String avatar;

  void _productFields() async {
    final Products_Basket = await _preferencesService.getProducts();
    setState(() {
      title = products_Basket.title;
      avatar = products_Basket.avatar;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: 2,
        itemBuilder: (context, index) {
          try {
            ListTile(
              title: Text('${title}'),
              subtitle: Text(title),
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(
                  avatar,
                ),
              ),
            );
          } catch (e) {
            Center(
              child: Text(e..toString()),
            );
          }
        },
      ),
    );
  }
}
