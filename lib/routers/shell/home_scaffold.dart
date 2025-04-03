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

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(memoWritingViewModelProvider);

    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollEndNotification &&
                    notification.metrics.pixels > 0 &&
                    state.visible) {
                  Future.delayed(const Duration(milliseconds: 100), () {
                    if (mounted) {
                      ref.read(memoWritingViewModelProvider.notifier).toggle();
                    }
                  });
                  return true;
                }
                return false;
              },
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    floating: true,
                    snap: true,
                    pinned: false,
                    flexibleSpace: VariableHeader(
                      type: widget.navigationShell.currentIndex == 0
                          ? HeaderType.date
                          : HeaderType.logo,
                      onSort: () => AlignSelect.show(context, ref),
                      onSearch: () => context.push(AppRoute.search),
                      onMore: () => context.push(AppRoute.settings),
                    ),
                  ),
                  if (widget.navigationShell.currentIndex == 0) ...[
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _TabMenuDelegate(
                        onTabChanged: (index) {
                          setState(() {
                            _currentTabIndex = index;
                          });
                        },
                      ),
                    ),
                  ],
                  const SliverToBoxAdapter(child: Divider(height: 1)),
                  SliverFillRemaining(
                    child: switch (_currentTabIndex) {
                      0 => const FeedView(),
                      1 => const BookmarkView(),
                      2 => const GalleryView(),
                      3 => const LinkList(),
                      _ => widget.navigationShell,
                    },
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: SafeArea(
            top: false,
            child: VariableNavigationBar(
              ref: ref,
              type: _currentNavBar,
              selectedIndex: widget.navigationShell.currentIndex,
              onItemSelected: (index) {
                setState(() {
                  _selectedIndex = index;
                  _goBranch(_selectedIndex);
                });
              },
              onFloatingButtonTap: () {
                //ref.read(writingStateProvider.notifier).toggle();
                ref.read(memoWritingViewModelProvider.notifier).toggle();
              },
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            transform: Matrix4.translationValues(
              0,
              state.visible ? 0 : MediaQuery.of(context).size.height,
              0,
            ),
            child: GestureDetector(
              onVerticalDragEnd: (details) {
                if (details.primaryVelocity! > 100) {
                  ref.read(memoWritingViewModelProvider.notifier).toggle();
                }
              },
              behavior: HitTestBehavior.translucent,
              child: const MemoWritingView(),
            ),
          ),
        )
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
