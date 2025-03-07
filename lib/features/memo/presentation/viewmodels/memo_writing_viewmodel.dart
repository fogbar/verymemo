import 'dart:async';
import 'dart:developer';
import 'package:image_picker/image_picker.dart';
import 'package:verymemo/common/barrel/model_common.dart';
import 'package:verymemo/features/auth/presentation/providers/user_provider.dart';
import 'package:verymemo/features/memo/domain/dtos/memo_dto.dart';
import 'package:verymemo/features/memo/domain/mappers/memo_mapper.dart';
import 'package:verymemo/features/memo/domain/models/image_model.dart';
import 'package:verymemo/features/memo/domain/models/memo_model.dart';
import 'package:verymemo/features/memo/presentation/memo_writing_view.dart';
import 'package:verymemo/features/memo/presentation/providers/memo_provider.dart';
import 'package:verymemo/features/memo/presentation/providers/writing_provider.dart';

final writingViewModelProvider = Provider((ref) {
  final memoNotifier = ref.watch(memoProvider.notifier);
  return WritingViewModel(ref, memoNotifier);
});

class WritingViewModel extends ChangeNotifier {
  final Ref ref;
  final MemoNotifier memoProvider;
  final TextEditingController textController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<ImageModel> selectedImages = [];
  bool visible = false;
  FocusNode focusNode = FocusNode();
  Timer? _debounce;
  String debouncedText = "";
  String get currentText => debouncedText;

  WritingViewModel(this.ref, this.memoProvider) {
    textController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(seconds: 1), () {
      debouncedText = textController.text;
      ref
          .read(writingMenuStateProvider.notifier)
          .setUploadButtonState(debouncedText);
      notifyListeners(); // 💡 상태 변경 알림
    });
  }

  void updateText(String text) {
    textController.text = text;
    notifyListeners(); // 상태 변경 알림
  }

  Future<bool> onWillPop() async {
    visible = false;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Future<void> pickImages() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage();
      if (images.isNotEmpty) {
        selectedImages.addAll(
            images.map((image) => ImageModel(imageUrl: image.path)).toList());
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
        child: const MemoWritingView(),
      ),
    );
  }

  MemoDTO makeMemoModel() {
    final user = ref.watch(userProvider.notifier).getUser();
    final content = debouncedText;
    final memoModel = MemoModel(
      userId: user?.id, // 🔄 userId 설정 (없으면 0)
      content: content,
      // imageUrls: selectedImages
      //     .map((image) => ImageModel(imageUrl: image.imageUrl))
      //     .toList(), // 🔄 이미지 리스트 그대로 사용
      imageUrls: selectedImages,
      links: [], // 🔄 빈 리스트 (링크)
      tags: [], // 🔄 빈 리스트 (태그)
      createdAt: DateTime.now(),
      updatedAt: null,
      isLocalMemo: 1, // 🔄 기본값 설정
    );
    return MemoMapper.toDTO(memoModel);
  }

  /// [메모 업로드 탭]
  /// 메모 업로드 후 메모 탭 닫기
  Future<void> onUploadTab() async {
    final memoDTO = makeMemoModel();
    final memoModel = MemoMapper.toModel(memoDTO); // 🔄 MemoDTO → MemoModel 변환
    await memoProvider.addMemo(memoModel); // 🔄 addMemo 호출
    debouncedText = "";
    selectedImages = [];
    visible = false;

    notifyListeners();
    log("---> 저장끝");
    log("---> visible: $visible");
  }

  void closeWriting(BuildContext context) {
    if (!context.mounted) return;
    Navigator.pop(context);
  }

  void removeImage(int index) {
    selectedImages.removeAt(index);
  }

  @override
  void dispose() {
    textController.removeListener(_onTextChanged);
    textController.dispose();
    _debounce?.cancel();
    super.dispose();
  }
}
