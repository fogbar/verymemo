// import 'package:flutter/material.dart';
// import 'package:verymemo/common/utils/image_util.dart';

// class MemoImagesCarousel extends StatelessWidget {
//   final List<String> imageUrls;

//   const MemoImagesCarousel({
//     super.key,
//     required this.imageUrls,
//   });

//   @override
//   Widget build(BuildContext context) {
//     const double imageSize = 72.0;
//     const double spacing = 8.0;
//     const double horizontalPadding = 16.0;

//     return SizedBox(
//       height: imageSize,
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         physics: const BouncingScrollPhysics(),
//         child: Row(
//           children: [
//             const SizedBox(width: horizontalPadding),
//             ...List.generate(
//               imageUrls.length,
//               (index) => Padding(
//                 padding: EdgeInsets.only(
//                   right: index == imageUrls.length - 1
//                       ? horizontalPadding
//                       : spacing,
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                   // child: Image.network(
//                   //   imageUrls[index],
//                   //   width: imageSize,
//                   //   height: imageSize,
//                   //   fit: BoxFit.cover,
//                   // ),
//                   child: ImageUtil.showImage(
//                     imageUrls[index],
//                     size: Size(imageSize, imageSize),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
