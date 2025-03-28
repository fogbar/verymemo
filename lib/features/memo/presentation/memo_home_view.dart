import 'package:verymemo/routers/router.dart';
import 'package:verymemo/common/barrel/memo_list.dart';
import 'package:verymemo/common/barrel/memo_writing.dart';
import 'package:verymemo/common/barrel/view_common.dart';
import 'package:verymemo/features/memo/presentation/components/modal/select/align.dart';

class MemoHomeView extends ConsumerStatefulWidget {
  const MemoHomeView({super.key});

  @override
  ConsumerState<MemoHomeView> createState() => _MemoHomeViewState();
}

class _MemoHomeViewState extends ConsumerState<MemoHomeView> {
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
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  floating: true,
                  snap: true,
                  pinned: false,
                  flexibleSpace: VariableHeader(
                    type:
                        _selectedIndex == 0 ? HeaderType.date : HeaderType.logo,
                    onSort: () => AlignSelect.show(context, ref),
                    onSearch: () => context.push(AppRoute.search),
                    onMore: () => context.push(AppRoute.settings),
                    // onBack: () => debugPrint("뒤로 가기 클릭"),
                  ),
                ),
                if (_selectedIndex == 0) ...[
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
                    0 => const MemoList(),
                    1 => const MemoList(),
                    2 => const GalleryView(),
                    3 => const LinkList(),
                    _ => const MemoList(),
                  },
                ),
              ],
            ),
          ),
          bottomNavigationBar: SafeArea(
            top: false,
            child: VariableNavigationBar(
              type: _currentNavBar,
              selectedIndex: _selectedIndex,
              onItemSelected: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              onFloatingButtonTap: () {
                ref.read(memoWritingViewModelProvider.notifier).toggle();
              },
            ),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutExpo,
          left: 0,
          right: 0,
          bottom: state.visible
              ? MediaQuery.of(context).viewInsets.bottom
              : -MediaQuery.of(context).size.height,
          child: Visibility(
            visible: state.visible,
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
