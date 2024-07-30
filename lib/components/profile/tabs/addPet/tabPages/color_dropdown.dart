import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final String selected;
  final void Function(String?) onChanged;

  CustomDropdown({
    Key? key,
    required this.items,
    required this.selected,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CustomDropdownState createState() =>
      _CustomDropdownState();
}

class _CustomDropdownState
    extends State<CustomDropdown> {
  String? _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.selected;
  }

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
          isEmpty: _currentValue == null ||
              _currentValue!.isEmpty,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _currentValue,
              isDense: true,
              onChanged: (String? newValue) {
                setState(() {
                  _currentValue = newValue;
                });
                widget.onChanged(newValue);
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
          'Selected value: ${_currentValue ?? 'None'}',
          style: const TextStyle(
              fontSize: 16.0, color: Colors.grey),
        ),
      ],
    );
  }
}
