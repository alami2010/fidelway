import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'language_provider.dart';

/// A more sophisticated dropdown menu for actions
class ActionDropDown extends StatelessWidget {
  const ActionDropDown({
    Key? key,
    required this.onActionSelected,
    required this.actions,
    this.selectedActionIndex,
    this.buttonColor,
    this.iconColor,
    this.menuWidth,
    this.menuElevation = 8.0,
    this.buttonLabel = 'Actions',
    this.buttonBorderRadius = 8.0,
    this.menuBorderRadius = 12.0,
  }) : super(key: key);

  /// Callback when an action is selected
  final void Function(int) onActionSelected;

  /// List of actions to display in the dropdown
  final List<ActionItem> actions;

  /// Currently selected action index (optional)
  final int? selectedActionIndex;

  /// Color of the dropdown button
  final Color? buttonColor;

  /// Color of icons in the dropdown
  final Color? iconColor;

  /// Width of the dropdown menu
  final double? menuWidth;

  /// Elevation of the dropdown menu
  final double menuElevation;

  /// Label for the dropdown button
  final String buttonLabel;

  /// Border radius for the dropdown button
  final double buttonBorderRadius;

  /// Border radius for the dropdown menu
  final double menuBorderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveIconColor = iconColor ?? theme.colorScheme.onSurface;
    final effectiveButtonColor = buttonColor ?? theme.colorScheme.surface;

    return PopupMenuButton<int>(
      elevation: menuElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(menuBorderRadius),
      ),
      offset: const Offset(0, 8),
      tooltip: AppLocalizations.of(context)!.showActions,
      onSelected: onActionSelected,
      itemBuilder: (context) => _buildMenuItems(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: effectiveButtonColor,
          borderRadius: BorderRadius.circular(buttonBorderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              buttonLabel,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              CupertinoIcons.chevron_down,
              size: 16,
              color: effectiveIconColor,
            ),
          ],
        ),
      ),
    );
  }

  List<PopupMenuItem<int>> _buildMenuItems(BuildContext context) {
    return actions.asMap().entries.map((entry) {
      final index = entry.key;
      final action = entry.value;

      return PopupMenuItem<int>(
        value: index,
        padding: EdgeInsets.zero,
        child: Container(
          width: menuWidth,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          child: _ActionMenuItem(
            icon: action.icon,
            label: action.label,
            iconColor: action.iconColor ?? iconColor,
            onTap: action.onTap,
            isSelected: selectedActionIndex == index,
            isDestructive: action.isDestructive,
          ),
        ),
      );
    }).toList();
  }
}

/// Represents an individual action in the dropdown
class ActionItem {
  const ActionItem({
    required this.label,
    required this.icon,
    this.onTap,
    this.iconColor,
    this.isDestructive = false,
  });

  /// Display label for the action
  final String label;

  /// Icon to display with the action
  final IconData icon;

  /// Optional callback when this specific action is tapped
  final VoidCallback? onTap;

  /// Color override for this action's icon
  final Color? iconColor;

  /// Whether this is a destructive action (will show in red)
  final bool isDestructive;
}

/// Widget for individual menu items in the dropdown
class _ActionMenuItem extends StatelessWidget {
  const _ActionMenuItem({
    Key? key,
    required this.icon,
    required this.label,
    this.iconColor,
    this.onTap,
    this.isSelected = false,
    this.isDestructive = false,
  }) : super(key: key);

  final IconData icon;
  final String label;
  final Color? iconColor;
  final VoidCallback? onTap;
  final bool isSelected;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Color textColor;
    if (isDestructive) {
      textColor = Colors.red.shade700;
    } else if (isSelected) {
      textColor = theme.colorScheme.primary;
    } else {
      textColor = theme.colorScheme.onSurface;
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: isDestructive ? Colors.red.shade700 : (iconColor ?? textColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: textColor,
                ),
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check,
                size: 18,
                color: theme.colorScheme.primary,
              ),
          ],
        ),
      ),
    );
  }
}

/// Example usage of the ActionDropDown component
class ExampleUsage extends StatelessWidget {
  const ExampleUsage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          return ActionDropDown(
            buttonLabel: AppLocalizations.of(context)!.actions,
      onActionSelected: (index) {
        // Handle action selection
        print('Selected action index: $index');

        // Execute the action's specific handler if available
        final action = actions[index];
        if (action.onTap != null) {
          action.onTap!();
        }
      },
      actions: actions,
      buttonColor: Colors.white,
      iconColor: Colors.black87,
      menuWidth: 280,
    );
  }

  List<ActionItem> get actions => [
        ActionItem(
    label: AppLocalizations.of(context)!.addNewReward,
          icon: CupertinoIcons.add_circled,
          onTap: () {
            // Show dialog to add new reward
            print('Show add dialog');
          },
        ),
        ActionItem(
    label: AppLocalizations.of(context)!.loadDefaultRewards,
          icon: CupertinoIcons.arrow_clockwise,
          onTap: () {
            // Load default rewards
            print('Load default rewards');
          },
        ),
        ActionItem(
    label: AppLocalizations.of(context)!.deleteAllRewards,
          icon: CupertinoIcons.delete,
          isDestructive: true,
          onTap: () {
            // Delete all rewards
            print('Delete all rewards');
          },
        ),
      ];
  }

  ,

  );
}
}