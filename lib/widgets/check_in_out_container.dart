import 'package:flutter/material.dart';

Widget buildStatusCircle({
  required Color color,
  required IconData icon,
  required String label,
}) {
  return Container(
    width: 150,
    height: 150,
    decoration: BoxDecoration(
      color: color.withOpacity(0.15),
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(0.3),
          blurRadius: 12,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 36),
        const SizedBox(height: 10),
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const Text("--", style: TextStyle(color: Colors.black54)),
      ],
    ),
  );
}
