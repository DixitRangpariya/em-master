import 'package:expanse_manage/common_widget/common_text.dart';
import 'package:flutter/material.dart';

class BuildChip extends StatelessWidget {
  final String label;
  final bool hasActionIcon;
  final Color color;
  final VoidCallback? onDelete;

  const BuildChip(
      {Key? key,
      required this.label,
      this.hasActionIcon = false,
      required this.color,
      this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      labelPadding: const EdgeInsets.all(2.0),
      label: CustomText(
        label,
        color: Colors.white,
      ),
      deleteIconColor: Colors.white,
      onDeleted: onDelete,
      deleteIcon: hasActionIcon
          ? const Icon(
              Icons.clear,
              size: 15,
            )
          : null,
      backgroundColor: color,
      elevation: 6.0,
      shadowColor: Colors.grey[60],
      padding: const EdgeInsets.all(8.0),
    );
  }
}
