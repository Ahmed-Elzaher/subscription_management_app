import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final Function(String) onCategoryChanged;

  const CategorySelector({super.key, required this.categories, required this.selectedCategory, required this.onCategoryChanged});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      separatorBuilder: (_, __) => const SizedBox(width: 12),
      itemBuilder: (context, index) {
        bool isSelected = categories[index] == selectedCategory;
        return GestureDetector(
          onTap: () => onCategoryChanged(categories[index]),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: isSelected ? Colors.blueAccent : Colors.white10),
              boxShadow: isSelected ? [BoxShadow(color: Colors.blueAccent.withOpacity(0.4), blurRadius: 12, spreadRadius: 1)] : [],
            ),
            child: Center(
              child: Text(categories[index], 
                style: TextStyle(color: isSelected ? Colors.white : Colors.white54, fontWeight: isSelected ? FontWeight.bold : FontWeight.w500)),
            ),
          ),
        );
      },
    );
  }
}