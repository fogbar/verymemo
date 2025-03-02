part of '../router.dart';

class HomeScaffold extends ConsumerStatefulWidget {
  final StatefulNavigationShell navigationShell;
  final GoRouterState state;
  const HomeScaffold({
    super.key,
    required this.navigationShell,
    required this.state,
  });

  @override
  ConsumerState<HomeScaffold> createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends ConsumerState<HomeScaffold> {
  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  final NavigationBarType _currentNavBar = NavigationBarType.home;
  int _selectedIndex = 0;
  int _currentTabIndex = 0;

  void _showWritingModal(BuildContext context) {
    ref.read(writingStateProvider.notifier).toggle();
  }

  @override
  Widget build(BuildContext context) {
    final isWritingVisible = ref.watch(writingStateProvider);

    return Stack(
      children: [
        Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: VariableHeader(
                    type: widget.navigationShell.currentIndex == 0
                        ? HeaderType.date
                        : HeaderType.logo,
                    onSort: () => debugPrint("정렬 클릭"),
                    onSearch: () => context.go(AppRoute.search),
                    onMore: () => context.go(AppRoute.settings),
                    onBack: () => debugPrint("뒤로 가기 클릭"),
                  ),
                ),
                if (widget.navigationShell.currentIndex == 0) ...[
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _TabMenuDelegate(
                      onTabChanged: (index) {
                        setState(() {
                          _currentTabIndex = index;
                          log("---> _currentTabIndex: $_currentTabIndex");
                          log("---> _selectedIntex: $_selectedIndex");
                        });
                      },
                    ),
                  ),
                ],
                const SliverToBoxAdapter(child: Divider(height: 1)),
                SliverFillRemaining(
                  child: switch (_currentTabIndex) {
                    0 => widget.navigationShell,
                    1 => widget.navigationShell,
                    2 => GalleryView(
                        onImageTap: (String imageUrl) {
                          debugPrint('Image tapped: $imageUrl');
                        },
                      ),
                    3 => const LinkList(),
                    _ => widget.navigationShell,
                  },
                ),
              ],
            ),
          ),
          bottomNavigationBar: SafeArea(
            top: false,
            child: VariableNavigationBar(
              type: _currentNavBar,
              selectedIndex: widget.navigationShell.currentIndex,
              onItemSelected: (index) {
                setState(() {
                  _selectedIndex = index;
                  _goBranch(_selectedIndex);
                  debugPrint("선택된 네비게이션 아이콘 인덱스: $_selectedIndex");
                });
              },
              onFloatingButtonTap: () {
                debugPrint("Floating button tapped!");
                _showWritingModal(context);
              },
            ),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutQuart,
          left: 0,
          right: 0,
          bottom: isWritingVisible ? 0 : -MediaQuery.of(context).size.height,
          child: const WritingView(),
        ),
      ],
    );
  }
}

class _TabMenuDelegate extends SliverPersistentHeaderDelegate {
  final Function(int)? onTabChanged;

  _TabMenuDelegate({this.onTabChanged});

  @override
  double get minExtent => 40;
  @override
  double get maxExtent => 40;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      height: maxExtent,
      color: Theme.of(context).colorScheme.surface,
      alignment: Alignment.center,
      child: TabMenu(onTabChanged: onTabChanged),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
