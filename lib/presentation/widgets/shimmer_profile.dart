import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileLoading extends StatelessWidget {
  const ProfileLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.black54,
          highlightColor: Colors.white10,
          period: const Duration(milliseconds: 500),
          child: Column(
            children: [
              //!profile card

              Container(
                color: Colors.white,
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * 0.32,
                child: const Padding(
                  padding: EdgeInsets.all(15),
                ),
              ),

              //! SizedBox
              const SizedBox(height: 12),

              //!My Cars
              Container(
                // padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              //! SizedBox
              const SizedBox(height: 12),

              //!My Reservations
              Container(
                // padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),

              //! SizedBox
              const SizedBox(height: 12),

              //!sign out
              Container(
                width: 100,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
