import 'package:flutter/material.dart';

class RoundedImageButton extends StatelessWidget {
  final String text;
  final String imagePath;
  final VoidCallback onPressed;

  const RoundedImageButton({
    Key? key,
    required this.text,
    required this.imagePath,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // Set color to transparent
      borderRadius: BorderRadius.circular(20.0),
      elevation: 5.0,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(20.0),
        splashColor:
            Colors.white.withOpacity(0.5), // Splash color with transparency
        child: Container(
          constraints: const BoxConstraints(minWidth: 100, maxHeight: 100),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.white, width: 2.0), // White border
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset(
                  imagePath,
                  height: 30.0,
                  width: 30.0,
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 12.0, // Small text size
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // White text color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';

// class RoundedImageButton extends StatelessWidget {
//   final String text;
//   final String imagePath;
//   final VoidCallback onPressed;

//   const RoundedImageButton({
//     Key? key,
//     required this.text,
//     required this.imagePath,
//     required this.onPressed,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.grey[800],
//       borderRadius: BorderRadius.circular(20.0),
//       elevation: 5.0,
//       child: InkWell(
//         onTap: onPressed,
//         borderRadius: BorderRadius.circular(20.0),
//         child: Container(
//           constraints: const BoxConstraints(minWidth: 100, maxHeight: 100),
//           padding: const EdgeInsets.all(10.0),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20.0),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(15.0),
//                 child: Image.asset(
//                   imagePath,
//                   height: 30.0,
//                   width: 30.0,
//                 ),
//               ),
//               const SizedBox(height: 5.0),
//               Text(
//                 text,
//                 style: const TextStyle(
//                   fontSize: 12.0, // Small text size
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white, // White text color
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
