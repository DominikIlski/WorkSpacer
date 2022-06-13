import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:work_spacer/models/filter.dart';
import 'package:work_spacer/models/workspace.dart';
import 'package:work_spacer/screens/admin/block/block_dialog.dart';
import 'package:work_spacer/screens/widgets/workspace_grid.dart';
import 'package:work_spacer/screens/widgets/rounded_button.dart';
import 'package:work_spacer/screens/widgets/filterable_workspace_list.dart';
import 'package:work_spacer/screens/widgets/filter_dialog.dart';
import 'package:work_spacer/stores/block_store.dart';

class WorkspaceBlockScreen extends StatefulWidget {
  static const routeName = '/block';

  const WorkspaceBlockScreen({super.key});

  @override
  State<WorkspaceBlockScreen> createState() => _WorkspaceBlockScreenState();
}

class _WorkspaceBlockScreenState extends State<WorkspaceBlockScreen> {
  final _pageController = PageController();
  int _selectedIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final blockStore = Provider.of<BlockStore>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Block a workspace'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FilterableWorkspaceList(
          observerFilterButtons: _getObserverFilterButtons(blockStore),
          child: _getContent(blockStore),
        ),
      ),
      bottomNavigationBar: _getNavBar(),
    );
  }

  List<Observer> _getObserverFilterButtons(blockStore) {
    return [
      Observer(
        builder: (_) => RoundedButton(
          title: filterParameterNames[FilterParameter.id] ?? '',
          isSelected:
              blockStore.filterStore.filters[FilterParameter.id] != null,
          onTap: () => _showFilterDialog(
            FilterParameter.id,
            blockStore.filterStore.toggleValueFilter,
            blockStore.filterStore.resetFilter,
            blockStore.filterStore.filters[FilterParameter.id]?.toString(),
          ),
        ),
      ),
      Observer(
        builder: (_) => RoundedButton(
          title: filterParameterNames[FilterParameter.floor] ?? '',
          isSelected:
              blockStore.filterStore.filters[FilterParameter.floor] != null,
          onTap: () => _showFilterDialog(
            FilterParameter.floor,
            blockStore.filterStore.toggleValueFilter,
            blockStore.filterStore.resetFilter,
            blockStore.filterStore.filters[FilterParameter.floor]?.toString(),
          ),
        ),
      ),
    ];
  }

  Widget _getContent(BlockStore blockStore) {
    return PageView(
      controller: _pageController,
      onPageChanged: (index) => _onNavBarItemTapped(
        index,
        pageScrolled: true,
      ),
      children: [
        Observer(
          builder: (_) => _getGrid(
            blockStore.inProgressDesks,
            blockStore.desks,
            blockStore.block,
          ),
        ),
        Observer(
          builder: (_) => _getGrid(
            blockStore.inProgressRooms,
            blockStore.rooms,
            blockStore.block,
          ),
        ),
      ],
    );
  }

  Widget _getGrid(
    bool inProgress,
    List<Workspace> workspaces,
    Function(Workspace workspace, DateTime startDate, DateTime endDate) onBlock,
  ) {
    if (inProgress) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return WorkspaceGrid(
        workspaces: workspaces,
        onTap: (workspace) => showDialog(
          context: context,
          builder: (context) => BlockDialog(
            workspace: workspace,
            onBlock: onBlock,
          ),
        ),
      );
    }
  }

  Widget _getNavBar() {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _getNavBarItem(
            theme,
            Icons.desktop_windows_outlined,
            0,
          ),
          _getNavBarItem(
            theme,
            Icons.meeting_room_outlined,
            1,
          ),
        ],
      ),
    );
  }

  Widget _getNavBarItem(ThemeData theme, IconData icon, int index) {
    return InkWell(
      borderRadius: BorderRadius.circular(32),
      onTap: () => _onNavBarItemTapped(index),
      child: Ink(
        decoration: BoxDecoration(
          color: _selectedIndex == index
              ? theme.colorScheme.primary
              : Colors.transparent,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
          child: Icon(
            icon,
            color: _selectedIndex == index
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.primary,
            size: 32,
          ),
        ),
      ),
    );
  }

  void _onNavBarItemTapped(int index, {bool pageScrolled = false}) {
    setState(() {
      _selectedIndex = index;
    });
    if (!pageScrolled) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _showFilterDialog(
    FilterParameter filter,
    Function(FilterParameter parameter, String valueAsString) onConfirm,
    Function(FilterParameter parameter) onReset,
    String? initialText,
  ) {
    showDialog(
      context: context,
      builder: (context) => FilterDialog(
        filter: filter,
        onConfirm: onConfirm,
        onReset: onReset,
        initialText: initialText,
      ),
    );
  }
}
