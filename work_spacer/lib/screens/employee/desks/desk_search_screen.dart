import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:work_spacer/models/desk.dart';
import 'package:work_spacer/models/filter.dart';
import 'package:work_spacer/models/workspace.dart';
import 'package:work_spacer/screens/employee/desks/components/grid_item.dart';
import 'package:work_spacer/screens/employee/desks/components/reserve_dialog.dart';
import 'package:work_spacer/screens/employee/desks/components/search_dialog.dart';
import 'package:work_spacer/screens/widgets/old_filter_button.dart';

enum SearchParameter { id, floor }

class DeskSearchScreen extends StatefulWidget {
  static const routeName = '/desks';

  const DeskSearchScreen({super.key});

  @override
  State<DeskSearchScreen> createState() => _DeskSearchScreenState();
}

class _DeskSearchScreenState extends State<DeskSearchScreen> {
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
      secondMonitor: true,
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
      secondMonitor: true,
    ),
    const Desk(
      id: 100,
      floor: 3,
      secondMonitor: false,
    )
  ];

  List<Workspace> _filteredList = [];

  int _selectedIndex = 0;
  PageController pageController = PageController();
  int _searchParameter = -1;
  SearchParameter _searchType = SearchParameter.id;
  bool _searchId = false;
  bool _searchFloor = false;

  void showReserveDialog(BuildContext context, Workspace workspace) {
    showDialog(
      context: context,
      builder: (context) => ReserveDialog(
        workspace: workspace,
        onReserveClicked: onReserveClicked,
      ),
    ).then((result) {
      if (result == 'confirm') {}
    });
  }

  void onReserveClicked(DateTime? start, DateTime? end, Workspace workspace) {
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
          if (_searchType == SearchParameter.floor) {
            _searchId = false;
            _searchFloor = true;
          } else if (_searchType == SearchParameter.id) {
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
        onItemClicked: () => showReserveDialog(context, list[index]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Desks'),
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
                    text: SearchParameter.id.name,
                    onClicked: () => _showSearchDialog(SearchParameter.id),
                    selected: _searchId,
                  ),
                  const SizedBox(width: 8),
                  FilterButton(
                    icon: Icons.stairs_outlined,
                    text: SearchParameter.floor.name,
                    onClicked: () => _showSearchDialog(SearchParameter.floor),
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
                children: [
                  buildGridView(desks),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
