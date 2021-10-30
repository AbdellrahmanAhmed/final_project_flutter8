import 'dart:convert';

import 'package:final_project_flutter8/components/cards/categories_card.dart';
import 'package:final_project_flutter8/model/categories.dart';
import 'package:final_project_flutter8/screen/products_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

import '../../sa_constants.dart';

class CategoriesCardLists extends StatefulWidget {
  const CategoriesCardLists({Key key}) : super(key: key);

  @override
  _CategoriesCardListsState createState() => _CategoriesCardListsState();
}

class _CategoriesCardListsState extends State<CategoriesCardLists> {
  List<Container> indication = [];
  int currentPage = 0;
  Future<DataModel> future;

  DataModel dataModel = DataModel();

  @override
  void initState() {
    super.initState();
    future = getData();
  }

  Future<DataModel> getData() async {
    /// Server LockUp - Get Response from it
    final response = await http
        .get(Uri.parse('https://retail.amit-learning.com/api/categories'));
    if (response.statusCode == 200) {
      // print('Data Model : ${jsonDecode(response.body)}');
      return dataModel = DataModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Data');
    }
  }

  Widget updateIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: dataModel.categories.map(
        (Categories) {
          var index = dataModel.categories.indexOf(Categories);
          return Container(
            width: 20.0,
            height: 7.0,
            margin: const EdgeInsets.symmetric(horizontal: 1.0),
            decoration: currentPage == index
                ? BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(42.0),
                    color: sASecondarBackgroundColor,
                    boxShadow: [
                      BoxShadow(
                          color: sABackgroundColor.withOpacity(0.9),
                          offset: const Offset(0, 20),
                          blurRadius: 30),
                      BoxShadow(
                          color: sASecondarBackgroundColor.withOpacity(0.3),
                          offset: const Offset(0, 20),
                          blurRadius: 30),
                    ],
                  )
                : const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
          );
        },
      ).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CategoriesFutureBuilder();
  }

  FutureBuilder<DataModel> CategoriesFutureBuilder() {
    return FutureBuilder(
      future: future,
      builder: (context, index) {
        switch (index.connectionState) {
          case ConnectionState.waiting:
            return Center(child: SpinKitSpinningLines(
              size: 50,
              color: sABackgroundColor,
              itemCount: 6,
              lineWidth: 5,
              duration: Duration(seconds: 2),
            ));
          default:
            return Column(children: [
              Container(
                  height: 320,
                  width: double.infinity,
                  child: PageView.builder(
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductsScreen(id: dataModel.categories[index].id, ),
                                fullscreenDialog: true,
                              ),
                            );
                          },
                          child: Opacity(
                            opacity: currentPage == index ? 1.0 : 0.45,
                            child: CategoriesCard(index, dataModel),
                          ));
                    },
                    itemCount: dataModel.categories.length,
                    controller:
                        PageController(initialPage: 0, viewportFraction: 0.75),
                    onPageChanged: (index) {
                      setState(() {
                        currentPage = index;
                      });
                    },
                  )),
              SizedBox(
                height: 6.0,
              ),
              updateIndicators()
            ]);
        }
      },
    );
  }
}
