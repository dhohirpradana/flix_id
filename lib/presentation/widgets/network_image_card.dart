import 'package:flutter/material.dart';

class NetworkImageCard extends StatelessWidget {
  final double width;
  final double height;
  final String? imageUrl;
  final BoxFit fit;
  final double borderRadius;
  final VoidCallback? onTap;

  const NetworkImageCard(
      {super.key,
      this.width = 150,
      this.height = 228,
      required this.imageUrl,
      this.fit = BoxFit.cover,
      this.borderRadius = 10,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Stack(
            children: [
              if (imageUrl != null)
                const Center(child: CircularProgressIndicator()),
              if (imageUrl != null)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                    image: DecorationImage(
                        image: NetworkImage(imageUrl!), fit: fit),
                  ),
                )
            ],
          ),
        ));
  }
}
