import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final String initialValue;

  const CustomDropdown(
      {super.key,
      required this.items,
      required this.initialValue});

  @override
  // ignore: library_private_types_in_public_api
  _CustomDropdownState createState() =>
      _CustomDropdownState();
}

class _CustomDropdownState
    extends State<CustomDropdown> {
  late String _currentSelectedValue;

  @override
  void initState() {
    super.initState();
    _currentSelectedValue = widget.initialValue;
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
          isEmpty: _currentSelectedValue == '',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _currentSelectedValue,
              isDense: true,
              onChanged: (String? newValue) {
                setState(() {
                  _currentSelectedValue =
                      newValue!;
                });
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
          'Selected value: $_currentSelectedValue',
          style: const TextStyle(
              fontSize: 16.0, color: Colors.grey),
        ),
      ],
    );
  }
}
