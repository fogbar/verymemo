part of '../router.dart';

class DetailScaffold extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  final GoRouterState state;
  const DetailScaffold({
    super.key,
    required this.navigationShell,
    required this.state,
  });

  @override
  State<DetailScaffold> createState() => _DetailScaffoldState();
}

class _DetailScaffoldState extends State<DetailScaffold> {
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: VariableHeader(
            type: HeaderType.content, onBack: () => context.go(AppRoute.home)),
      ),
      body: SafeArea(
        child: widget.navigationShell,
      ),
    );
  }
}
