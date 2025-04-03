import 'package:flutter/material.dart';

class MultiSelectDropDown extends StatefulWidget {
  const MultiSelectDropDown({
    super.key,
    required this.dropDownItems,
    required this.onSelectionChanged,
    this.initialValue,
    this.validator,
  });

  final List<String> dropDownItems;
  final Function(List<String>) onSelectionChanged;
  final String? initialValue;
  final String? Function(String?)? validator;

  @override
  State<MultiSelectDropDown> createState() => _MultiSelectDropDownState();
}

class _MultiSelectDropDownState extends State<MultiSelectDropDown> {
  List<String> selected = [];

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      validator: widget.validator,
      controller: TextEditingController(
        text:
            widget.initialValue ??
            (selected.isNotEmpty ? selected.join(", ") : ""),
      ),
      decoration: InputDecoration(
        hintText: "Select",
        suffixIcon: const Icon(Icons.arrow_drop_down),
      ),
      onTap: () {
        _showMultiSelectDialog(context);
      },
    );
  }

  void _showMultiSelectDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Select Options"),
          content: SingleChildScrollView(
            child: Column(
              children:
                  widget.dropDownItems.map((e) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return CheckboxListTile(
                          value: selected.contains(e),
                          title: Text(e),
                          onChanged: (isSelected) {
                            setState(() {
                              if (isSelected == true) {
                                selected.add(e);
                              } else {
                                selected.remove(e);
                              }
                              widget.onSelectionChanged(selected);
                            });
                          },
                        );
                      },
                    );
                  }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ],
        );
      },
    ).then((_) {
      setState(() {}); // Refresh TextField when dialog closes
    });
  }
}
