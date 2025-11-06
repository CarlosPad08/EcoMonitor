import 'package:flutter/material.dart';

class ThemeSection extends StatefulWidget {
  const ThemeSection({super.key});

  @override
  State<ThemeSection> createState() => _ThemeSectionState();
}

class _ThemeSectionState extends State<ThemeSection> {
  String selectedTheme = 'Claro';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tema',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF4A148C),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildRadioOption('Oscuro', selectedTheme == 'Oscuro', (value) {
              setState(() {
                selectedTheme = value;
              });
            }),
            const SizedBox(width: 20),
            _buildRadioOption('Claro', selectedTheme == 'Claro', (value) {
              setState(() {
                selectedTheme = value;
              });
            }),
            const SizedBox(width: 20),
            _buildRadioOption('Automático', selectedTheme == 'Automático', (value) {
              setState(() {
                selectedTheme = value;
              });
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildRadioOption(String value, bool isSelected, Function(String) onChanged) {
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? const Color(0xFF4A148C) : Colors.transparent,
              border: Border.all(
                color: const Color(0xFF4A148C),
                width: 2,
              ),
            ),
            child: isSelected
                ? const Icon(
                    Icons.check,
                    size: 12,
                    color: Colors.white,
                  )
                : null,
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              color: const Color(0xFF4A148C),
            ),
          ),
        ],
      ),
    );
  }
}
