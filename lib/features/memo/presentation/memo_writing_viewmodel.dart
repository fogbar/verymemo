import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:verymemo/features/memo/presentation/memo_writing_view.dart';

class WritingViewModel extends ChangeNotifier {
  final TextEditingController textController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<String> selectedImages = [];

  Future<void> pickImages() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage();
      if (images.isNotEmpty) {
        selectedImages.addAll(images.map((image) => image.path));
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error picking images: $e');
    }
  }

  void expandWriting(BuildContext context) {
    if (!context.mounted) return;

    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double screenHeight = mediaQuery.size.height;
    final double keyboardHeight = mediaQuery.viewInsets.bottom;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SizedBox(
        height: screenHeight - keyboardHeight - mediaQuery.padding.top,
        child: const WritingView(),
      ),
    );
  }

  void closeWriting(BuildContext context) {
    if (!context.mounted) return;
    Navigator.pop(context);
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
