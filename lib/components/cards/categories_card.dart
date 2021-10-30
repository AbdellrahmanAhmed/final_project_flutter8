import 'package:flutter/material.dart';

import '../../sa_constants.dart';

Container CategoriesCard(int index, var dataModel) {
  return Container(
    alignment: Alignment.center,
    child: Stack(
      alignment: Alignment.topRight,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20.0, right: 20.0),
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [sABackgroundColor, sASecondarBackgroundColor],
              ),
              borderRadius: BorderRadius.circular(41.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.deepOrange.withOpacity(0.3),
                    offset: const Offset(0, 05),
                    blurRadius: 15),
                BoxShadow(
                    color: Colors.teal.withOpacity(0.3),
                    offset: const Offset(0, 05),
                    blurRadius: 15),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(41.0),
              child: Container(
                height: 500,
                width: 260,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(26.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              "Loading..",
                              style: TextStyle(color: Colors.white70),
                            ),
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          // Hero(
                          //   tag: course.courseTitle,
                          //   child: Text(
                          //     course.courseTitle,
                          //     style: sACardTitleStyle,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Image.network(
                      dataModel.categories[index].avatar,
                      fit: BoxFit.cover,
                      height: 500,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [sABackgroundColor, sASecondarBackgroundColor],
            ),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(36.0),
                topRight: Radius.circular(21.0),
                bottomLeft: Radius.circular(11.0),
                bottomRight: Radius.circular(11.0)),
            boxShadow: [
              BoxShadow(
                  color: Colors.deepOrange.withOpacity(0.3),
                  offset: const Offset(0, 05),
                  blurRadius: 15),
              BoxShadow(
                  color: Colors.teal.withOpacity(0.3),
                  offset: const Offset(0, 05),
                  blurRadius: 15),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              dataModel.categories[index].name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: sASubtitleStyle.copyWith(
                fontSize: 30,
                fontFamily: 'Horizon',
                color: Colors.white70,
              ),
            ),
          ),
        ),
        // Hero(
        //   tag: course.logo,
        //   child: Container(
        //     child: Image.asset('asset/icons/icon-play.png'),
        //     width: 60.0,
        //     height: 60.0,
        //     decoration: BoxDecoration(
        //       gradient: RadialGradient(
        //         colors: [
        //           course.background.colors[1].withOpacity(0.95),
        //           course.background.colors[0].withOpacity(0.95),
        //         ],
        //       ),
        //       borderRadius: BorderRadius.circular(18.0),
        //       boxShadow: const [
        //         BoxShadow(
        //             color: sAShadowColor,
        //             offset: Offset(-4, 4),
        //             blurRadius: 5),
        //       ],
        //     ),
        //     padding: const EdgeInsets.only(
        //         right: 14.0, left: 20.0, top: 12.5, bottom: 13.5),
        //   ),
        // ),
      ],
    ),
  );
}
