// lib/features/shared/comment_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realm/realm.dart';

import '../../widgets/comments/comment_section.dart';

class CommentWidget extends ConsumerStatefulWidget {
  String? get postId => null;

  @override
  ConsumerState<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends ConsumerState<CommentWidget> {
  @override
  Widget build(BuildContext context) {
    final comments = ref.watch(commentsProvider(widget.postId)).value ?? [];
    
    return Column(
      children: [
        TextField(
          onSubmitted: (text) => _addComment(text),
          decoration: InputDecoration(
            hintText: 'Add comment...',
            suffixIcon: IconButton(
              icon: const Icon(Icons.send),
              onPressed: () => _addComment(_controller.text),
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: comments.length,
          itemBuilder: (ctx, i) => StreamBuilder<RealmObjectChanges<CommentModel>>(
            stream: comments[i].changes,
            builder: (context, snapshot) {
              final comment = snapshot.data?.object ?? comments[i];
              return CommentTile(comment: comment);
            },
          ),
        ),
      ],
    );
  }
}

class CommentTile {
}

class CommentModel {
}

class _controller {
  static var text;
}

class _addComment {
  _addComment(text);
}