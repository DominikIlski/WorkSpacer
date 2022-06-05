import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:work_spacer/models/filter.dart';
import 'package:work_spacer/models/workspace.dart';
import 'package:work_spacer/screens/admin/block/components/block_dialog.dart';
import 'package:work_spacer/screens/admin/block/components/search_dialog.dart';
import 'package:work_spacer/screens/admin/block/components/workspace_grid.dart';
import 'package:work_spacer/screens/widgets/filter_button.dart';
import 'package:work_spacer/stores/block_store.dart';

enum SearchParameter { id, floor }

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
        child: Column(
          children: [
            SizedBox(
              height: 32,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  Center(
                    child: Observer(
                      builder: (_) => FilterButton(
                        filter: FilterParameter.id,
                        isSelected: blockStore
                                .filterStore.filters[FilterParameter.id] !=
                            null,
                        onTap: () => _showSearchDialog(
                          FilterParameter.id,
                          blockStore.filterStore.toggleValueFilter,
                          blockStore.filterStore.resetFilter,
                          blockStore.filterStore.filters[FilterParameter.id]
                              ?.toString(),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Observer(
                      builder: (_) => FilterButton(
                        filter: FilterParameter.floor,
                        isSelected: blockStore
                                .filterStore.filters[FilterParameter.floor] !=
                            null,
                        onTap: () => _showSearchDialog(
                          FilterParameter.floor,
                          blockStore.filterStore.toggleValueFilter,
                          blockStore.filterStore.resetFilter,
                          blockStore.filterStore.filters[FilterParameter.floor]
                              ?.toString(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //_getFilters(),
            const SizedBox(height: 16),
            Divider(
              height: 0,
              thickness: 1,
              color: Theme.of(context).secondaryHeaderColor,
            ),
            const SizedBox(height: 12),
            Expanded(
              child: _getContent(blockStore),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _getNavBar(),
    );
  }

  Widget _getContent(BlockStore blockStore) {
    return PageView(
      controller: _pageController,
      onPageChanged: (index) => _onBottomNavItemTapped(
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
    Function(Workspace workspace) onBlock,
  ) {
    if (inProgress) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return WorkspaceGrid(
        workspaces: workspaces,
        onTap: (workspace) => _showBlockDialog(workspace, onBlock),
      );
    }
  }

  Widget _getNavBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onBottomNavItemTapped,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.desktop_windows_outlined),
          label: 'Desks',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.meeting_room_outlined),
          label: 'Rooms',
        ),
      ],
      backgroundColor: Theme.of(context).primaryColorDark,
      selectedItemColor: Colors.white,
      unselectedItemColor: Theme.of(context).primaryColor,
    );
  }

  void _onBottomNavItemTapped(int index, {bool pageScrolled = false}) {
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

  void _showBlockDialog(
    Workspace workspace,
    Function(Workspace workspace) onBlock,
  ) {
    showDialog(
      context: context,
      builder: (context) => BlockDialog(
        workspace: workspace,
        onBlock: onBlock,
      ),
    );
  }

  void _onBlockClicked(DateTime start, DateTime end, Workspace workspace) {
    //TODO: enter blockage
  }

  void _showSearchDialog(
    FilterParameter filter,
    Function(FilterParameter parameter, String valueAsString) onConfirm,
    Function(FilterParameter parameter) onReset,
    String? initialText,
  ) {
    showDialog(
      context: context,
      builder: (context) => SearchDialog(
        filter: filter,
        onConfirm: onConfirm,
        onReset: onReset,
        initialText: initialText,
      ),
    );
  }
}
