import 'package:verymemo/common/barrel/model_common.dart';
import 'package:verymemo/common/configs/storage_key.dart';
import 'package:verymemo/common/utils/platform_util.dart';
import 'package:verymemo/externals/storage/storage_service.dart';
import 'package:verymemo/routers/navigation_service.dart';
import 'package:verymemo/routers/router.dart';

class IntroViewModel extends ChangeNotifier {
  final PageController pageController = PageController();
  final NavigationService _navigationService;
  final StorageService _storageService;
  int currentPage = 0;

  final List<IntroContent> contents = [
    IntroContent(
      title: '밑으로 끌어당겨\n빠른 메모 쓰기',
      imagePath: 'assets/images/test_image.png',
    ),
    IntroContent(
      title: 'PC와 모바일\n언제 어디서나 가볍게 쓰기',
      imagePath: 'assets/images/test_image.png',
    ),
    IntroContent(
      title: '링크도 이미지도\n한눈에 보기 쉽게',
      imagePath: 'assets/images/test_image.png',
    ),
    IntroContent(
      title: '공유하고 저장하고\n편리한 메모 관리',
      imagePath: 'assets/images/test_image.png',
    ),
  ];

  IntroViewModel(this._navigationService, this._storageService) {
    // 초기화 시 페이지 컨트롤러 리스너 추가
    pageController.addListener(() {
      if (pageController.page?.round() != currentPage) {
        onPageChanged(pageController.page?.round() ?? 0);
      }
    });
  }

  void onPageChanged(int page) {
    currentPage = page;
    notifyListeners();
  }

  void onStartButtonPressed() async {
    final deviceId = await PlatformUtil.getPlatformInfo();
    // 여기서 넘어갈 때, 최초 접속자가 아니라는 의미로 deviceId를 DB에 저장
    _storageService.set(key: deviceIdKey, data: deviceId);
    // 로그인 화면으로 라우팅
    _navigationService.push(AppRoute.signup);
  }

  @override
  void dispose() {
    pageController.removeListener(() {}); // 리스너 제거
    pageController.dispose();
    super.dispose();
  }
}

class IntroContent {
  final String title;
  final String? subtitle;
  final String imagePath;

  IntroContent({
    required this.title,
    this.subtitle,
    required this.imagePath,
  });
}

final introProvider = ChangeNotifierProvider<IntroViewModel>((ref) {
  final navigationService = ref.watch(navigationServiceProvider);
  final storageService = ref.watch(storageProvider);
  return IntroViewModel(navigationService, storageService);
});
