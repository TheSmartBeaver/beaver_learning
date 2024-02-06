import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final List<DropDownItem> items;
  final String label;
  final double? width;
  final TextEditingController? dpController;
  final void Function(DropDownItem?)? onSelected;

  const CustomDropdown(
      {super.key,
      required this.items,
      required this.label,
      this.dpController,
      this.onSelected,
      this.width});

  @override
  State<StatefulWidget> createState() {
    return _CustomDropdown();
  }
}

class DropDownItem {
  const DropDownItem(this.label, this.value);
  final String label;
  final String value;
}

class _CustomDropdown extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownMenu<DropDownItem>(
      controller: widget.dpController,
      enableFilter: true,
      requestFocusOnTap: true,
      width: widget.width,
      leadingIcon: const Icon(Icons.search),
      label: Text(widget.label),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 5.0),
      ),
      onSelected: widget.onSelected,
      dropdownMenuEntries: widget.items.map<DropdownMenuEntry<DropDownItem>>(
        (DropDownItem icon) {
          return DropdownMenuEntry<DropDownItem>(
              value: icon, label: icon.label);
        },
      ).toList(),
    );
  }
}
