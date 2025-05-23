import 'package:flutter/material.dart';

/// Reusable Dashboard Card
Widget dashboardCard({
  required IconData icon,
  required String label,
  required Color color,
}) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.8), color.withOpacity(0.5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 30),
          const SizedBox(height: 8),
          Text(label,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white)),
        ],
      ),
    ),
  );
}