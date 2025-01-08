import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_mate/utils/app_constant.dart';

class HeadingWidget extends StatelessWidget {
  final String headingTile;
  final String headingSubTile;
  final VoidCallback onTap;
  final String buttonText;

  const HeadingWidget({
    super.key,
    required this.buttonText,
    required this.headingSubTile,
    required this.headingTile,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  headingTile,
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                 headingSubTile,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            GestureDetector(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 1.5,
                    color: AppConstant.appScendoryColor,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                   buttonText,
                    style: TextStyle(
                      color: AppConstant.appScendoryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
