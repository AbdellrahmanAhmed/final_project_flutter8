import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../sa_constants.dart';
import 'basket_list.dart';

void main() => runApp(One_Product_Screen());

class One_Product_Screen extends StatelessWidget {
  One_Product_Screen(
      {@required this.title,
      this.name,
      this.avatar,
      this.description,
      this.discount,
      this.inStock,
      this.price,
      this.priceFinal,
      this.currency,
      this.id});

  final String title;
  final String name;
  final String description;
  var price;
  final String discount;
  final String avatar;
  final String inStock;
  var priceFinal;
  final String currency;
  var id;
  var quantity;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).pop();
          },
          label: const Text('Back'),
          // icon: const Icon(Icons.arrow_back),
          backgroundColor: sABackgroundColor,
          splashColor: sASecondarBackgroundColor,
          elevation: 10,
        ),
        bottomNavigationBar: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [sASecondarBackgroundColor, sABackgroundColor])),
              height: 45,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      print("clicked");
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => BasketScreen(title: title,)));
                      void _saveSettings() {
                        final newProducts = Products_Basket(
                            name: name,
                            avatar: avatar,
                            id: id,
                            currency: currency,
                            description: description,
                            discount: discount,
                            price: price,
                            priceFinal: priceFinal,
                            title: title);
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width - 60,
                            child: Center(
                                child: Text("إضافة إلى عربة التسوق",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      fontFamily: 'SF Pro Text',
                                      decoration: TextDecoration.none,
                                    ))))
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        color: Colors.white,
                        width: 60,
                        height: 20,
                        child: Center(child: Text("الكمية")),
                      ),
                      Container(
                        color: Colors.white,
                        width: 60,
                        height: 25,
                        child: Expanded(
                          child: TextField(
                            onChanged: (value) {},
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.numberWithOptions(
                                decimal: false, signed: false),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        body: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'asset/illustrations/Product.png',
                  ),
                  fit: BoxFit.fitHeight,
                ),
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  children: [
                    Container(
                      // color: Colors.blue,
                      height: 250,
                      child: Stack(
                        children: [
                          Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(avatar),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.0)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              transform: Matrix4.translationValues(0, 120, 100),
                              height: 130,
                              width: 130,
                              child: Hero(
                                tag: avatar,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      gradient: LinearGradient(colors: [
                                        sASecondarBackgroundColor,
                                        sABackgroundColor
                                      ])),
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Image.network(
                                      avatar,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            transform: Matrix4.translationValues(145, 205, 100),
                            height: 65,
                            width: MediaQuery.of(context).size.width - 150,
                            child: Hero(
                              tag: title,
                              child: sATypewriter(
                                text: title,
                                style: sASubtitleStyle.copyWith(
                                    fontWeight: FontWeight.bold),
                                duration: 50,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            gradient: LinearGradient(colors: [
                              sASecondarBackgroundColor,
                              sABackgroundColor
                            ])),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: Colors.white),
                            child: Expanded(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                // color: Colors.amber,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${price.toString()} ${currency}",
                                        textAlign: TextAlign.start,
                                        style: sATitle2Style.apply(
                                            decoration: discount != 0
                                                ? TextDecoration.lineThrough
                                                : null),
                                      ),
                                      discount != 0
                                          ? Text(
                                              "discount ${discount} %",
                                              textAlign: TextAlign.start,
                                              overflow: TextOverflow.ellipsis,
                                            )
                                          : Container(),
                                      discount != 0
                                          ? Text(
                                              "${priceFinal.toString()} ${currency}",
                                              textAlign: TextAlign.start,
                                              style: sATitle2Style,
                                            )
                                          : Container()
                                    ],
                                  ),
                                ),
                              ),
                            )),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            name,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 6.0,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              gradient: description != null
                                  ? LinearGradient(
                                      tileMode: TileMode.mirror,
                                      colors: [
                                          sASecondarBackgroundColor
                                              .withOpacity(0.8),
                                          sABackgroundColor.withOpacity(0.9)
                                        ])
                                  : null,
                            ),
                            height: 150,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  description != null ? description : "",
                                  style: sAHeadlineLabelStyle.apply(
                                      color: Colors.black87)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

