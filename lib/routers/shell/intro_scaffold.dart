part of '../router.dart';

class IntroScaffold extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  final GoRouterState state;
  const IntroScaffold({
    super.key,
    required this.navigationShell,
    required this.state,
  });

  @override
  State<IntroScaffold> createState() => _IntroScaffoldState();
}

class _IntroScaffoldState extends State<IntroScaffold> {
  void goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: ImageUtil.showImage("assets/images/img_bg_screen.jpg"),
          ),
          Column(
            children: <Widget>[
              widget.navigationShell.expanded,
            ],
          ),
        ],
      ),
    );
  }
}
