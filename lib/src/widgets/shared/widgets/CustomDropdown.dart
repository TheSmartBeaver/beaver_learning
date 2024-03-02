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
    return _CustomDropdown();
  }
}

class DropDownItem<T> {
  const DropDownItem(this.label, this.value);
  final String label;
  final T value;
}

class _CustomDropdown extends State<CustomDropdownMenu> {
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
          widget.value = item;
        });

        if (widget.onSelected != null) {
          widget.onSelected!(item);
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

// class CustomDropdownButton extends StatefulWidget {
//   final List<DropDownItem> items;
//   final String label;
//   final double? width;
//   final TextEditingController? dpController;
//   final void Function(DropDownItem?)? onSelected;
//   DropDownItem? _selectedValue;

//   CustomDropdownButton(
//       {super.key,
//       required this.items,
//       required this.label,
//       this.width,
//       this.dpController,
//       this.onSelected});

//   @override
//   _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
// }

// class _CustomDropdownButtonState extends State<CustomDropdownButton> {
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton(
//       onChanged: (newValue) {},
//       //value: widget._selectedValue,
//       items: items.map<DropdownMenuItem<DropDownItem>>(
//         (DropDownItem dpItem) {
//           return DropdownMenuItem<DropDownItem>(
//               value: dpItem, child: Text(dpItem.label));
//         },
//       ).toList(),
//     );
//   }
// }
