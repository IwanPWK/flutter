import 'package:flutter/material.dart';
import 'package:flutter_beauty_date/constants.dart';
import 'package:flutter_beauty_date/screens/dashboard/header.dart';
import 'package:flutter_beauty_date/screens/dashboard/row_1.dart';
import 'package:flutter_beauty_date/screens/dashboard/row_2.dart';
import 'package:flutter_beauty_date/screens/dashboard/row_3.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({
    super.key,
    required ScrollController scrollController,
    required ScrollController scrollControllerUncoming,
  }) : _scrollController = scrollController,
       _scrollControllerUncoming = scrollControllerUncoming;

  final ScrollController _scrollController;
  final ScrollController _scrollControllerUncoming;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: defaultPadding * 2,
        vertical: defaultPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Header(),
          SizedBox(height: defaultPadding),
          Row1(),
          SizedBox(height: defaultPadding),
          Row2(),
          SizedBox(height: defaultPadding),
          Row3(
            scrollController: _scrollController,
            scrollControllerUncoming: _scrollControllerUncoming,
          ),
        ],
      ),
    );
  }
}
