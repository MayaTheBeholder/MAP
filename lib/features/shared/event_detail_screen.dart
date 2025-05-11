// lib/features/shared/event_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/event_announcement_model.dart';
import 'like_button.dart';
import 'comment_widget.dart';

class EventDetailScreen extends ConsumerStatefulWidget {
  final String eventCode;
  const EventDetailScreen({required this.eventCode, super.key});

  @override
  ConsumerState<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends ConsumerState<EventDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final eventAsync = ref.watch(eventProvider(widget.eventCode));

    return Scaffold(
      body: eventAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
        data: (event) => CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                background: event.picturePath != null 
                  ? Image.asset(event.picturePath!, fit: BoxFit.cover)
                  : Container(color: Colors.grey),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(event.title, style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 16),
                        const SizedBox(width: 4),
                        Text(DateFormat.yMMMd().format(event.eventTime)),
                        const SizedBox(width: 16),
                        Icon(Icons.location_on, size: 16),
                        const SizedBox(width: 4),
                        Text(event.location),
                      ],
                    ),
                    const SizedBox(height: 16),
                    LikeButton(
                      likeCount: event.likeCount,
                      isLiked: ref.watch(eventLikeProvider(event.eventCode)),
                      onPressed: () => _handleLike(event.eventCode),
                    ),
                    const Divider(),
                    const Text('Teams Participating'),
                    Wrap(
                      spacing: 8,
                      children: event.teams
                          .map((team) => Chip(label: Text(team.teamName)))
                          .toList(),
                    ),
                    // ... event details
                    CommentWidget(
                      comments: event.comments,
                      onCommentAdded: (text) => _addComment(event.eventCode, text),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleLike(String eventCode) {
    ref.read(eventServiceProvider).toggleLike(eventCode);
  }

  void _addComment(String eventCode, String text) {
    ref.read(eventServiceProvider).addComment(eventCode, text);
  }
}