import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../sa_constants.dart';

class SearchFieldWidget extends StatelessWidget {
  const SearchFieldWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(200.0),
              boxShadow: shadow),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: TextField(
              autofocus: false,
              cursorColor: sAPrimaryLabelColor,
              decoration: InputDecoration(
                icon: const Icon(
                  Icons.search,
                  color: sAPrimaryLabelColor,
                  size: 20.0,
                ),
                border: InputBorder.none,
                hintText: "...",
                hintStyle: sASearchPlaceholderStyle,
              ),
              style: sASearchTextStyle,
              onChanged: (newText) {
                print(newText);
              },
            ),
          ),
        ),
      ),
    );
  }
}