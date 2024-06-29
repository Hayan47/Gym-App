import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class EquipmentLoadingWidget extends StatelessWidget {
  const EquipmentLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        5,
        (index) {
          return Shimmer.fromColors(
            baseColor: Colors.black26,
            highlightColor: Colors.white10,
            period: const Duration(milliseconds: 500),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                width: double.infinity,
                height: 400,
                child: const Padding(
                  padding: EdgeInsets.all(15),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
