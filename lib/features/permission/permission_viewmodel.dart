// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final permissionProvider =
//     StateNotifierProvider<PermissionViewModel, PermissionState>((ref) {
//   return PermissionViewModel();
// });

// class PermissionState {
//   final bool isAgreed;

//   PermissionState({
//     this.isAgreed = true,
//   });

//   PermissionState copyWith({
//     bool? isAgreed,
//   }) {
//     return PermissionState(
//       isAgreed: isAgreed ?? this.isAgreed,
//     );
//   }
// }

// class PermissionViewModel extends StateNotifier<PermissionState> {
//   PermissionViewModel() : super(PermissionState());

//   void checkAgreement(String type) {
//     final newValue = !state.isAgreed;
//     state = state.copyWith(isAgreed: newValue);
//   }

//   void onStartButtonPressed() {
//     // 시작 버튼 로직 구현
//   }

  // void onTermsPressed(String type) {
  //   switch (type) {
  //     case 'service':
  //       // 서비스 이용 약관 페이지로 이동
  //       print("서비스 이용 약관 페이지로 이동");
  //       break;
  //     case 'privacy':
  //       // 개인정보 처리방침 페이지로 이동
  //       print("개인정보 처리방침 페이지로 이동");
  //       break;
  //   }
  // }
// }
