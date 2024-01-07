import 'package:flix_id/presentation/misc/method.dart';
import 'package:flutter/material.dart';

class BackNavigationBar extends StatelessWidget {
  final String? title;
  final VoidCallback? onTap;

  const BackNavigationBar({super.key, this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: SizedBox(
            width: 40,
            height: 40,
            child: Image.asset('assets/back.png'),
          ),
        ),
        horizontalSpace(20),
        // - SizedBox width = 40
        // - horizontalSpace = 20
        // - Margin left = 24 and Margin right = 24
        SizedBox(
          width: MediaQuery.of(context).size.width - 40 - 20 - 24 - 24,
          child: Text(
            title!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
