import 'dart:convert';

import 'package:final_project_flutter8/model/products.dart';
import 'package:final_project_flutter8/screen/one_product_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

import '../sa_constants.dart';

class ProductsScreen extends StatefulWidget {
  ProductsScreen({@required this.id});

  final int id;

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen>
    with TickerProviderStateMixin {
  Future<DataModelproducts> futureproducts;
  DataModelproducts dataModelproducts = DataModelproducts();
  List productsCurrent = [];
  var photoURL = FirebaseAuth.instance.currentUser.photoURL;

  @override
  void initState() {
    super.initState();
    futureproducts = getDataproducts();
  }

  Future<DataModelproducts> getDataproducts() async {
    /// Server LockUp - Get Response from it
    final response = await http
        .get(Uri.parse('https://retail.amit-learning.com/api/products'));
    if (response.statusCode == 200) {
      print('Data Model : ${jsonDecode(response.body)}');
      return dataModelproducts =
          DataModelproducts.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProductsFutureBuilder();
  }

  FutureBuilder<DataModelproducts> ProductsFutureBuilder() {
    return FutureBuilder(
      future: futureproducts,
      builder: (context, index) {
        switch (index.connectionState) {
          case ConnectionState.waiting:
            return Center(
                child: SpinKitSpinningLines(
              size: 50,
              color: sABackgroundColor,
              itemCount: 6,
              lineWidth: 5,
              duration: Duration(seconds: 2),
            ));
          default:
            if (index.hasError) {
              print(index.error);
              print(index.connectionState);
              print(index.data);
              print(index.hasData);
              return Center(
                  child: Text(
                'تحقق من إتصال الإنترنت',
                textAlign: TextAlign.center,
              ));
            } else {
              productsCurrent = List.from(dataModelproducts.products
                  .where((element) => element.categoryId == widget.id));
              return Scaffold(
                resizeToAvoidBottomInset: true,
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  label: const Text('Back'),
                  icon: const Icon(Icons.arrow_back),
                  backgroundColor: sABackgroundColor,
                  splashColor: sASecondarBackgroundColor,
                  elevation: 10,
                ),
                body: Container(
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
                    child: ListView.builder(
                      shrinkWrap: true,
                      clipBehavior: Clip.antiAlias,
                      itemCount: dataModelproducts.products
                          .where((element) => element.categoryId == widget.id)
                          .length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => One_Product_Screen(
                                          id: productsCurrent[index].id,
                                          title: productsCurrent[index].title,
                                          avatar: productsCurrent[index].avatar,
                                          description: productsCurrent[index]
                                              .description,
                                          discount: productsCurrent[index]
                                              .discount
                                              .toString(),
                                          inStock: productsCurrent[index]
                                              .inStock
                                              .toString(),
                                          name: productsCurrent[index].name,
                                          price: productsCurrent[index].price,
                                          priceFinal:
                                              productsCurrent[index].priceFinal,
                                          currency: productsCurrent[index]
                                              .currency
                                              .toString(),
                                        ),
                                    fullscreenDialog: false));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 250,
                              // color: Colors.teal,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                              height: 130,
                                              width: 130,
                                              child: Stack(
                                                children: [
                                                  Center(
                                                    child: Text(
                                                      "Loading...",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                  ),
                                                  Hero(
                                                    tag: productsCurrent[index]
                                                        .avatar,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12.0),
                                                          gradient:
                                                              LinearGradient(
                                                                  colors: [
                                                                sASecondarBackgroundColor,
                                                                sABackgroundColor
                                                              ])),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(6.0),
                                                        child: Image.network(
                                                          productsCurrent[index]
                                                              .avatar,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ))
                                        ],
                                      ),
                                      Container(
                                        // color: Colors.red,
                                        height: 100,
                                        width: 260,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Hero(
                                                      tag:
                                                          productsCurrent[index]
                                                              .title,
                                                      child: Text(
                                                        productsCurrent[index]
                                                            .title,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: sASubtitleStyle
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                height: 2,
                                                // color: Colors.grey,
                                              ),
                                            ),
                                            Container(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                productsCurrent[index].name,
                                                textAlign: TextAlign.start,
                                                style:
                                                    sACardSubtitleStyle.apply(
                                                  color: Colors.grey,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                            )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: productsCurrent[index].description !=
                                            null
                                        ? Container(
                                            // color: Colors.blue,
                                            height: 50,
                                            child: Text(
                                              productsCurrent[index]
                                                  .description,
                                              textAlign: TextAlign.start,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                            ))
                                        : null,
                                  ),
                                  Text(
                                    "تبقى ${productsCurrent[index].inStock}  فقط - أطلبه الآن.",
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(color: Color(0xff9b0612)),
                                  ),
                                  Expanded(
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
                                              "${productsCurrent[index].price.toString()} ${productsCurrent[index].currency}",
                                              textAlign: TextAlign.start,
                                              style: sATitle2Style.apply(
                                                  decoration:
                                                      productsCurrent[index]
                                                                  .discount !=
                                                              0
                                                          ? TextDecoration
                                                              .lineThrough
                                                          : null),
                                            ),
                                            productsCurrent[index].discount != 0
                                                ? Text(
                                                    "discount ${productsCurrent[index].discount.toString()} %",
                                                    textAlign: TextAlign.start,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  )
                                                : Container(),
                                            productsCurrent[index].discount != 0
                                                ? Text(
                                                    "${productsCurrent[index].priceFinal.toString()} ${productsCurrent[index].currency.toString()}",
                                                    textAlign: TextAlign.start,
                                                    style: sATitle2Style,
                                                  )
                                                : Container()
                                          ],
                                        ),
                                      ),
                                    ),
                                  ))
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            }
        }
      },
    );
  }
}
