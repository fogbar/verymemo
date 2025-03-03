import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  void closeWriting(BuildContext context) {
    Navigator.pop(context);
  }

  void expandWriting(BuildContext context) {
    // TODO: 전체 화면으로 확장하는 로직 구현
    debugPrint('확장 기능 구현 예정');
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
