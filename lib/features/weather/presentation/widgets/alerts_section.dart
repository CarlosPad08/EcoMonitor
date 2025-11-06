import 'package:flutter/material.dart';

class AlertsSection extends StatefulWidget {
  const AlertsSection({super.key});

  @override
  State<AlertsSection> createState() => _AlertsSectionState();
}

class _AlertsSectionState extends State<AlertsSection> {
  String selectedFrequency = 'En tiempo real';
  final Map<String, bool> alertTypes = {
    'Lluvia fuerte': true,
    'Alta radiación solar': false,
    'Cambios bruscos de presión (tormentas)': true,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Frecuencia de alertas',
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
            _buildRadioOption('En tiempo real', selectedFrequency == 'En tiempo real', (value) {
              setState(() {
                selectedFrequency = value;
              });
            }),
            const SizedBox(width: 20),
            _buildRadioOption('Cada hora', selectedFrequency == 'Cada hora', (value) {
              setState(() {
                selectedFrequency = value;
              });
            }),
          ],
        ),
        const SizedBox(height: 8),
        _buildRadioOption('Solo eventos críticos', selectedFrequency == 'Solo eventos críticos', (value) {
          setState(() {
            selectedFrequency = value;
          });
        }),
        const SizedBox(height: 24),
        
        Text(
          'Selección de tipos de alerta',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF4A148C),
          ),
        ),
        const SizedBox(height: 16),
        ...alertTypes.keys.map((alertType) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: _buildCheckboxOption(
              alertType,
              alertTypes[alertType]!,
              (value) {
                setState(() {
                  alertTypes[alertType] = value;
                });
              },
            ),
          );
        }).toList(),
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

  Widget _buildCheckboxOption(String label, bool isSelected, Function(bool) onChanged) {
    return GestureDetector(
      onTap: () => onChanged(!isSelected),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF4A148C) : Colors.transparent,
              border: Border.all(
                color: const Color(0xFF4A148C),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: isSelected
                ? const Icon(
                    Icons.check,
                    size: 12,
                    color: Colors.white,
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: const Color(0xFF4A148C),
              ),
            ),
          ),
        ],
      ),
    );
  }
}