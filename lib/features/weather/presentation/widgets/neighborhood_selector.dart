import 'package:flutter/material.dart';

class NeighborhoodSelector extends StatefulWidget {
  const NeighborhoodSelector({super.key});

  @override
  State<NeighborhoodSelector> createState() => _NeighborhoodSelectorState();
}

class _NeighborhoodSelectorState extends State<NeighborhoodSelector> {
  final List<String> neighborhoods = [
    'Barrio Santa Bárbara',
    'Barrio Los Girasoles',
    'Barrio Versalles',
  ];

  final Set<String> selectedNeighborhoods = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: neighborhoods.map((neighborhood) {
        final isSelected = selectedNeighborhoods.contains(neighborhood);
        
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: GestureDetector(
            onTap: () {
              setState(() {
                if (isSelected) {
                  selectedNeighborhoods.remove(neighborhood);
                } else {
                  selectedNeighborhoods.add(neighborhood);
                }
              });
            },
            child: Builder(
              builder: (context) {
                final colorScheme = Theme.of(context).colorScheme;
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? colorScheme.primary.withOpacity(0.2)
                        : colorScheme.surface.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected 
                          ? colorScheme.primary
                          : colorScheme.outline.withOpacity(0.3),
                      width: isSelected ? 2 : 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Icono de ubicación
                      Icon(
                        Icons.location_on,
                        color: isSelected 
                            ? colorScheme.primary
                            : colorScheme.onSurface.withOpacity(0.7),
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      
                      // Nombre del barrio
                      Expanded(
                        child: Text(
                          neighborhood,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isSelected 
                                ? colorScheme.primary
                                : colorScheme.onSurface,
                          ),
                        ),
                      ),
                      
                      // Icono de selección
                      Icon(
                        isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                        color: isSelected 
                            ? colorScheme.primary
                            : colorScheme.onSurface.withOpacity(0.7),
                        size: 24,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      }).toList(),
    );
  }
}
