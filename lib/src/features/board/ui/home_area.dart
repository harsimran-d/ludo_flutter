import 'package:flutter/material.dart';

class HomeArea extends StatelessWidget {
  const HomeArea({
    super.key,
    required this.homeColor,
    required this.boxWidth,
    this.left,
    this.top,
    this.right,
    this.bottom,
  });

  final Color homeColor;
  final double boxWidth;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: left,
        top: top,
        right: right,
        bottom: bottom,
        child: SizedBox(
          height: 6 * boxWidth,
          width: 6 * boxWidth,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(),
              color: homeColor,
            ),
            child: Center(
              child: Container(
                decoration:
                    BoxDecoration(color: Colors.white, border: Border.all()),
                child: SizedBox(
                  width: boxWidth * 4,
                  height: boxWidth * 4,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      return Center(
                          child: Container(
                        width: boxWidth * 1,
                        height: boxWidth * 1,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(),
                          color: homeColor,
                        ),
                      ));
                    },
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
