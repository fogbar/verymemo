// import 'package:flutter/material.dart';
// import 'package:verymemo/common/utils/image_util.dart';

// class MemoImagesGrid extends StatelessWidget {
//   final List<String> imageUrls;

//   const MemoImagesGrid({
//     super.key,
//     required this.imageUrls,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final remainingCount = imageUrls.length > 5 ? imageUrls.length - 5 : 0;
//     final displayCount = imageUrls.take(5).length;
//     final useFixedSize = displayCount <= 2;

//     return Row(
//       children: imageUrls.take(5).toList().asMap().entries.map((entry) {
//         final int index = entry.key;
//         final String url = entry.value;

//         Widget imageContent = ClipRRect(
//           borderRadius: BorderRadius.circular(4),
//           child: index == 4 && remainingCount > 0
//               ? Stack(
//                   fit: StackFit.expand,
//                   children: [
//                     // Image.network(
//                     //   url,
//                     //   fit: BoxFit.cover,
//                     // ),
//                     ImageUtil.showImage(url, fit: BoxFit.cover),
//                     Container(
//                       color: Theme.of(context).colorScheme.surfaceDim,
//                       child: Center(
//                         child: Text(
//                           '+$remainingCount',
//                           style:
//                               Theme.of(context).textTheme.titleLarge?.copyWith(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 )
//               : Image.network(
//                   url,
//                   fit: BoxFit.cover,
//                 ),
//         );

//         Widget sizedContent = SizedBox(
//           width: 104,
//           height: 104,
//           child: imageContent,
//         );

//         Widget paddedContent = Padding(
//           padding: EdgeInsets.only(
//             right: index < displayCount - 1 ? 8.0 : 0,
//           ),
//           child: useFixedSize
//               ? sizedContent
//               : AspectRatio(
//                   aspectRatio: 1,
//                   child: imageContent,
//                 ),
//         );

//         return useFixedSize ? paddedContent : Expanded(child: paddedContent);
//       }).toList(),
//     );
//   }
// }
