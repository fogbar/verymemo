import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:verymemo/features/memo/presentation/memo_writing_view.dart';

class WritingViewModel extends ChangeNotifier {
  final TextEditingController textController = TextEditingController();
  List<String> selectedImages = [];

  Future<void> pickImages(BuildContext context) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
        allowCompression: true,
      );

      if (result != null && result.files.isNotEmpty) {
        final paths = result.files
            .where((file) => file.path != null)
            .map((file) => file.path!)
            .toList();

        selectedImages.addAll(paths);
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
