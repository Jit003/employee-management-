import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  final String label;
  final IconData icon;
  final String? value;
  final List<String> items;
  final Function(String?) onChanged;

  const CustomDropdownField({
    Key? key,
    required this.label,
    required this.icon,
    required this.value,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100, // background color
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.black),
          const SizedBox(width: 12),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: value == '' ? null : value,
                items: items.map((String val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Text(val),
                  );
                }).toList(),
                onChanged: onChanged,
                hint: Text(label),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
