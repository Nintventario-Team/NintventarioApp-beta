import 'package:flutter/material.dart';

/// A search bar widget for filtering items based on user input.
class SearchBar extends StatelessWidget {
  /// A callback function that is called when the text in the search bar changes.
  final ValueChanged<String> onChanged;

  /// Constructs a `SearchBar`.
  ///
  /// The `onChanged` parameter must not be null.
  const SearchBar({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: onChanged,
        decoration: const InputDecoration(
          labelText: 'Search by code or name',
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}
