

import 'package:flutter/material.dart';

class HorizontalImageList extends StatelessWidget {
  final List<String> images;

  const HorizontalImageList({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: Colors.grey[800],
            child: Container(
              height: 150,
              width: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: AssetImage(images[index]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}