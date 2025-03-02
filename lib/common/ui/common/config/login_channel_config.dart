import 'dart:developer';
import 'package:verymemo/common/ui/common/config/login_channel.dart';

List<LoginChannel> loginChannelConfigs = [
  LoginChannel(
    title: "동기화를 위한 가입",
    logo: "assets/images/img_logo_google.png",
    onPressed: () => log("---> Google"),
    isUser: true,
  ),
  LoginChannel(
    title: "애플 아이디로 가입",
    logo: "assets/images/img_logo_apple.svg",
    onPressed: () => log("---> Apple"),
    isUser: true,
  ),
  LoginChannel(
    title: "비회원으로 시작",
    logo: "assets/icons/ic_user.svg",
    isUser: false,
  ),
];
