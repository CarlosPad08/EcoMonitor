import 'package:flutter/material.dart';

class UnitsSection extends StatefulWidget {
  const UnitsSection({super.key});

  @override
  State<UnitsSection> createState() => _UnitsSectionState();
}

class _UnitsSectionState extends State<UnitsSection> {
  String selectedTemperature = '°C';
  String selectedPressure = 'hPa';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Unidades',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF4A148C),
          ),
        ),
        const SizedBox(height: 16),
        
        // Temperatura
        Text(
          'Temperatura',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF4A148C),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildRadioOption('°C', selectedTemperature == '°C', (value) {
              setState(() {
                selectedTemperature = value;
              });
            }),
            const SizedBox(width: 20),
            _buildRadioOption('°F', selectedTemperature == '°F', (value) {
              setState(() {
                selectedTemperature = value;
              });
            }),
          ],
        ),
        const SizedBox(height: 16),
        
        // Presión
        Text(
          'Presión',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF4A148C),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildRadioOption('hPa', selectedPressure == 'hPa', (value) {
              setState(() {
                selectedPressure = value;
              });
            }),
            const SizedBox(width: 20),
            _buildRadioOption('mmHg', selectedPressure == 'mmHg', (value) {
              setState(() {
                selectedPressure = value;
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
