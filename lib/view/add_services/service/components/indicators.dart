import 'package:flutter/material.dart';

class Indicators extends StatelessWidget {
  const Indicators(
      {super.key, required this.length, required this.currentIndex});
  final int length;
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          length,
          (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            margin: const EdgeInsets.symmetric(horizontal: 3),
            height: currentIndex == index ? 8 : 6,
            width: currentIndex == index ? 14 : 6,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4), color: Colors.white),
          ),
        ),
      ),
    );
  }
}
