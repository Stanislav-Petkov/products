import 'package:flutter/material.dart';

class ProductLoader extends StatelessWidget {
  const ProductLoader({super.key});

  @override
  Widget build(BuildContext context) => Positioned.fill(
        child: IgnorePointer(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
}
