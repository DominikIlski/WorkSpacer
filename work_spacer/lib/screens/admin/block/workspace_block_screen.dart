import 'package:flutter/material.dart';
import 'package:work_spacer/models/room.dart';
import 'package:work_spacer/models/workspace.dart';
import 'package:work_spacer/screens/admin/block/components/block_dialog.dart';
import 'package:work_spacer/screens/admin/block/components/search_dialog.dart';
import '../../../models/desk.dart';
import '../../../screens/components/filter_button.dart';
import 'components/grid_item.dart';

enum SearchParameter {
  ID,
  Floor,
}

class WorkspaceBlockScreen extends StatefulWidget {
  static const routeName = '/block';

  WorkspaceBlockScreen({super.key});

  @override
  State<WorkspaceBlockScreen> createState() => _WorkspaceBlockScreenState();
}

class _WorkspaceBlockScreenState extends State<WorkspaceBlockScreen> {
  final List<Workspace> desks = [
    const Desk(
      id: 1,
      floor: 2,
      secondMonitor: false,
    ),
    const Desk(
      id: 13,
      floor: 1,
      secondMonitor: false,
    ),
    const Desk(
      id: 14,
      floor: 2,
      secondMonitor: false,
    ),
    const Desk(
      id: 18,
      floor: 1,
      secondMonitor: false,
    ),
    const Desk(
      id: 33,
      floor: 1,
      secondMonitor: false,
    ),
    const Desk(
      id: 57,
      floor: 1,
      secondMonitor: false,
    ),
    const Desk(
      id: 69,
      floor: 2,
      secondMonitor: false,
    ),
    const Desk(
      id: 78,
      floor: 3,
      secondMonitor: false,
    ),
    const Desk(
      id: 81,
      floor: 2,
      secondMonitor: false,
    ),
    const Desk(
      id: 100,
      floor: 3,
      secondMonitor: false,
    )
  ];

  final List<Workspace> rooms = [
    const Room(
      id: 1,
      floor: 1,
      capacity: 12,
      hasProjector: false,
      hasWhiteboard: false,
      hasTeleconference: false,
    ),
    const Room(
      id: 3,
      floor: 2,
      capacity: 16,
      hasProjector: false,
      hasWhiteboard: false,
      hasTeleconference: false,
    ),
    const Room(
      id: 5,
      floor: 2,
      capacity: 22,
      hasProjector: false,
      hasWhiteboard: false,
      hasTeleconference: false,
    ),
    const Room(
      id: 6,
      floor: 1,
      capacity: 30,
      hasProjector: false,
      hasWhiteboard: false,
      hasTeleconference: false,
    ),
    const Room(
      id: 12,
      floor: 3,
      capacity: 16,
      hasProjector: false,
      hasWhiteboard: false,
      hasTeleconference: false,
    ),
    const Room(
      id: 13,
      floor: 1,
      capacity: 25,
      hasProjector: false,
      hasWhiteboard: false,
      hasTeleconference: false,
    ),
  ];

  List<Workspace> _filteredList = [];

  int _selectedIndex = 0;
  PageController pageController = PageController();
  int _searchParameter = -1;
  SearchParameter _searchType = SearchParameter.ID;
  bool _searchId = false;
  bool _searchFloor = false;

  void onBottomNavItemTapped(int index, {bool pageScrolled = false}) {
    setState(() {
      _selectedIndex = index;
    });
    if (!pageScrolled) {
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 333), curve: Curves.easeIn);
    }
  }

  void showBlockDialog(BuildContext context, Workspace workspace) {
    showDialog(
      context: context,
      builder: (context) => BlockDialog(
        workspace: workspace,
        onBlockClicked: onBlockClicked,
      ),
    ).then((result) {
      if (result == 'confirm') {}
    });
  }

  void onBlockClicked(DateTime? start, DateTime? end, Workspace workspace) {
    if (start == null || end == null) {
      //TODO: handle situation when any of the chosen date is null
      return;
    } else if (start.compareTo(end) < 0) {
      //TODO: handle situation when start date is less tahn end date
    }

    //TODO: enter blockage
  }

  void _setSearchParameter(int value, SearchParameter type) {
    setState(() {
      _searchParameter = value;
      _searchType = type;
    });
  }

  void _showSearchDialog(SearchParameter searchParameter) {
    showDialog(
      context: context,
      builder: (context) => SearchDialog(
        parameter: searchParameter.name,
        onConfirm: (value) => _setSearchParameter(value, searchParameter),
      ),
    ).then((result) {
      setState(() {
        if (result == 'confirm') {
          if (_searchType == SearchParameter.Floor) {
            _searchId = false;
            _searchFloor = true;
          } else if (_searchType == SearchParameter.ID) {
            _searchId = true;
            _searchFloor = false;
          }
        } else if (result == 'cancel') {
          _searchId = false;
          _searchFloor = false;
          _searchParameter = -1;
        }
      });
    });
  }

  GridView buildGridView(List<Workspace> list) {
    return GridView.builder(
      itemCount: list.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemBuilder: (context, index) => GridItem(
        workspace: list[index],
        onItemClicked: () => showBlockDialog(context, list[index]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Block a workspace'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FilterButton(
                    icon: Icons.numbers_rounded,
                    text: SearchParameter.ID.name,
                    onClicked: () => _showSearchDialog(SearchParameter.ID),
                    selected: _searchId,
                  ),
                  const SizedBox(width: 8),
                  FilterButton(
                    icon: Icons.stairs_outlined,
                    text: SearchParameter.Floor.name,
                    onClicked: () => _showSearchDialog(SearchParameter.Floor),
                    selected: _searchFloor,
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            Divider(
              height: 1,
              thickness: 0.6,
              color: Theme.of(context).secondaryHeaderColor,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: (index) =>
                    onBottomNavItemTapped(index, pageScrolled: true),
                children: [
                  buildGridView(desks),
                  buildGridView(rooms),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColorDark,
          unselectedItemColor: Theme.of(context).primaryColor,
          selectedItemColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
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
          currentIndex: _selectedIndex,
          onTap: onBottomNavItemTapped),
    );
  }
}
