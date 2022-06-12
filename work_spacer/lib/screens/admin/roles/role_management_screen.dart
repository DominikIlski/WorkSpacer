import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:work_spacer/models/filter.dart';
import 'package:work_spacer/screens/admin/roles/manage_role_dialog.dart';
import 'package:work_spacer/screens/admin/roles/user_list_item.dart';
import 'package:work_spacer/screens/widgets/filter_dialog.dart';
import 'package:work_spacer/screens/widgets/filterable_workspace_list.dart';
import 'package:work_spacer/screens/widgets/rounded_button.dart';
import 'package:work_spacer/stores/role_management_store.dart';

class RoleManagementScreen extends StatelessWidget {
  static const routeName = '/roles';

  const RoleManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final roleStore = Provider.of<RoleManagementStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(translate.manageRoles),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FilterableWorkspaceList(
          observerFilterButtons: _getObserverFilterButtons(roleStore),
          child: _getContent(context, roleStore),
        ),
      ),
    );
  }

  List<Observer> _getObserverFilterButtons(RoleManagementStore roleStore) {
    return [
      Observer(
        builder: (context) => RoundedButton(
          title: filterParameterNames[FilterParameter.id] ?? '',
          isSelected: roleStore.filterStore.filters[FilterParameter.id] != null,
          onTap: () => _showFilterDialog(
            context,
            FilterParameter.id,
            roleStore.filterStore.toggleValueFilter,
            roleStore.filterStore.resetFilter,
            roleStore.filterStore.filters[FilterParameter.id]?.toString(),
          ),
        ),
      ),
      Observer(
        builder: (context) => RoundedButton(
          title: filterParameterNames[FilterParameter.name] ?? '',
          isSelected:
              roleStore.filterStore.filters[FilterParameter.name] != null,
          onTap: () => _showFilterDialog(
            context,
            FilterParameter.name,
            roleStore.filterStore.toggleValueFilter,
            roleStore.filterStore.resetFilter,
            roleStore.filterStore.filters[FilterParameter.name]?.toString(),
          ),
        ),
      ),
      Observer(
        builder: (context) => RoundedButton(
          title: filterParameterNames[FilterParameter.surname] ?? '',
          isSelected:
              roleStore.filterStore.filters[FilterParameter.surname] != null,
          onTap: () => _showFilterDialog(
            context,
            FilterParameter.surname,
            roleStore.filterStore.toggleValueFilter,
            roleStore.filterStore.resetFilter,
            roleStore.filterStore.filters[FilterParameter.surname]?.toString(),
          ),
        ),
      ),
    ];
  }

  Widget _getContent(context, RoleManagementStore roleStore) {
    return Observer(
      builder: (_) {
        if (roleStore.inProgress) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Observer(
            builder: (_) => ListView.builder(
              itemCount: roleStore.users.length,
              itemBuilder: (context, index) => UserListItem(
                user: roleStore.users[index],
                onEditClicked: () => showDialog(
                  context: context,
                  builder: (context) => ManageRoleDialog(
                    user: roleStore.users[index],
                    onEditRole: roleStore.setUserRole,
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }

  void _showFilterDialog(
    context,
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
