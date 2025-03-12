part of '../router.dart';

class EmptyScaffold extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  final GoRouterState state;
  const EmptyScaffold({
    super.key,
    required this.navigationShell,
    required this.state,
  });

  @override
  State<EmptyScaffold> createState() => _EmptyScaffoldState();
}

class _EmptyScaffoldState extends State<EmptyScaffold> {
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
      body: SafeArea(
        child: widget.navigationShell,
      ),
    );
  }
}
