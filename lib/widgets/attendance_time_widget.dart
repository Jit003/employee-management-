// Punch Info Card Widget
import 'package:flutter/material.dart';

Widget punchInfoCard({
  required IconData icon,
  required Color iconColor,
  required String label,
  required String time,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
    padding: const EdgeInsets.all(5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: LinearGradient(
        colors: [
          Colors.white.withOpacity(0.4),
          Colors.white.withOpacity(0.1),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
      border: Border.all(
        color: Colors.white.withOpacity(0.3),
      ),
    ),
    child: Row(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: iconColor.withOpacity(0.15),
          ),
          padding: const EdgeInsets.all(12),
          child: Icon(icon, color: iconColor, size: 28),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        )
      ],
    ),
  );
}
