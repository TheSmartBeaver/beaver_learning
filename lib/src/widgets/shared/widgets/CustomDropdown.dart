import 'package:beaver_learning/src/screens/card_editor.dart';
import 'package:flutter/material.dart';

class CustomDropdownMenu<T> extends StatefulWidget {
  final List<DropDownItem<T>> items;
  final String label;
  final double? width;
  final TextEditingController dpController = TextEditingController();
  final void Function(DropDownItem<T>?)? onSelected;
  DropDownItem<T>? value;
  bool isInitialized = false;

  CustomDropdownMenu(
      {super.key,
      required this.items,
      required this.label,
      //this.dpController,
      this.value,
      this.onSelected,
      this.width});

  DropDownItem<T>? getValue() {
    return value;
  }

  @override
  State<StatefulWidget> createState() {
    return _CustomDropdown<T>();
  }
}

class DropDownItem<T> {
  const DropDownItem(this.label, this.value);
  final String label;
  final T value;
}

class _CustomDropdown<T> extends State<CustomDropdownMenu<T>> {
  @override
  void initState() {
    super.initState();
    if (widget.value != null && !widget.isInitialized) {
      widget.dpController.text = widget.items
          .firstWhere((element) => element.value == widget.value?.value)
          .label;
    }
    widget.isInitialized = true;
  }

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
      onSelected: (DropDownItem? item) {
        setState(() {
          widget.value = item as DropDownItem<T>?;
        });

        if (widget.onSelected != null) {
          widget.onSelected!(item as DropDownItem<T>?);
        }
      },
      dropdownMenuEntries: widget.items.map<DropdownMenuEntry<DropDownItem>>(
        (DropDownItem dpItem) {
          return DropdownMenuEntry<DropDownItem>(
              value: dpItem, label: dpItem.label);
        },
      ).toList(),
    );
  }
}
