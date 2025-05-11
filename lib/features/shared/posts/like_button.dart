// lib/features/shared/posts/like_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LikeButton extends ConsumerWidget {
  final int likeCount;
  final bool isLiked;
  final VoidCallback onPressed;

  const LikeButton({
    required this.likeCount,
    required this.isLiked,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isLiked ? Icons.favorite : Icons.favorite_border,
            color: isLiked ? AppColors.accent : Colors.grey,
          ),
          const SizedBox(width: 4),
          Text('$likeCount'),
        ],
      ),
    );
  }
}