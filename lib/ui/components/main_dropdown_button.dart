import 'package:flutter/material.dart';

import '../../constantes.dart';

class MainDropdownButton<T> extends StatefulWidget {

  final List<T> values;
  final ValueChanged<dynamic> onChange;
  final T? initialValue;

  const MainDropdownButton({super.key, required this.values, required this.onChange, this.initialValue});

  @override
  State<MainDropdownButton> createState() => _MainDropdownButtonState<T>();
}

class _MainDropdownButtonState<T> extends State<MainDropdownButton> {

  T? selectedValue;

  @override
  void initState() {
    selectedValue = widget.initialValue ?? widget.values[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      decoration: BoxDecoration(
          color: bordersColor,
          borderRadius: BorderRadius.circular(10.0)
      ),
      child: DropdownButton<T>(
        value: selectedValue,
        underline: const SizedBox(),
        icon: const SizedBox(),
        style: const TextStyle(fontSize: 20.0, color: Colors.white),
        dropdownColor: bordersColor,
        onChanged: (T? newValue) {
          setState(() {
            selectedValue = newValue;
            widget.onChange(newValue);
          });
        },
        items: widget.values.map<DropdownMenuItem<T>>((dynamic value) {
          return DropdownMenuItem<T>(
            value: value,
            child: Text(value.toString()),
          );
        }).toList(),
      ),
    );
  }
}
