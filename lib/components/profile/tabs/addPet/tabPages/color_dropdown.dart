import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomDropdown extends StatefulWidget {
  final List<String> items;
  String selected;
  final void Function(String?)
      onChanged; // Add this

  CustomDropdown({
    super.key,
    required this.items,
    required this.selected,
    required this.onChanged, // Add this
  });

  @override
  _CustomDropdownState createState() =>
      _CustomDropdownState();
}

class _CustomDropdownState
    extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        InputDecorator(
          decoration: InputDecoration(
            errorStyle: const TextStyle(
                color: Colors.pinkAccent,
                fontSize: 16.0),
            hintText: 'Please select a value',
            border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(8.0)),
          ),
          isEmpty: widget.selected == '',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: widget.selected,
              isDense: true,
              onChanged: (String? newValue) {
                setState(() {
                  widget.selected =
                      newValue ?? ''; // Safeguard
                });
                widget.onChanged(
                    newValue); // Call the callback
              },
              items: widget.items
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        Text(
          'Selected value: ${widget.selected}',
          style: const TextStyle(
              fontSize: 16.0, color: Colors.grey),
        ),
      ],
    );
  }
}
