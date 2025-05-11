import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/comment_service.dart';

class CommentSection extends ConsumerWidget {
  final String postCode;

  const CommentSection({super.key, required this.postCode});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentsAsync = ref.watch(commentsProvider(postCode));

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Add a comment...',
              suffixIcon: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  // Implement comment submission
                },
              ),
            ),
          ),
        ),
        commentsAsync.when(
          loading: () => const CircularProgressIndicator(),
          error: (error, _) => Text('Error: $error'),
          data: (comments) => ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: comments.length,
            itemBuilder: (context, index) {
              final comment = comments[index];
              return ListTile(
                leading: const CircleAvatar(),
                title: Text(comment.user?.username ?? 'Anonymous'),
                subtitle: Text(comment.commentText),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.thumb_up,
                        color: comment.likedBy.isNotEmpty
                            ? Colors.blue
                            : null,
                      ),
                      onPressed: () {
                        // Implement like functionality
                      },
                    ),
                    Text('${comment.likedBy.length}'),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

final commentsProvider = FutureProvider.family<List<Comment>, String>((ref, postCode) {
  return ref.read(commentServiceProvider).getCommentsForPost(postCode);
});