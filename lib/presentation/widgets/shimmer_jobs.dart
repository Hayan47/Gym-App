import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class JobsLoadingWidget extends StatelessWidget {
  const JobsLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
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
              height: 150,
              child: const Padding(
                padding: EdgeInsets.all(15),
              ),
            ),
          ),
        );
      },
    );
  }
}
