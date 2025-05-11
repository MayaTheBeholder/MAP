// lib/features/user/user_dashboard.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/event_announcement_model.dart';
import '../../data/models/update_post_model.dart';
import '../shared/event_card.dart';
import '../shared/post_card.dart';

class UserDashboard extends ConsumerWidget {
  const UserDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(upcomingEventsProvider);
    final posts = ref.watch(recentPostsProvider);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Namibia Hockey Union'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.event), text: 'Events'),
              Tab(icon: Icon(Icons.newspaper), text: 'News'),
              Tab(icon: Icon(Icons.star), text: 'Highlights'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Events Tab
            _buildEventsList(events, context),
            // News Tab
            _buildPostsList(posts, context),
            // Highlights Tab
            _buildHighlightsList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildEventsList(AsyncValue<List<UpcomingEventAnnouncement>> events, BuildContext context) {
    return events.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text('Error: $err')),
      data: (events) => ListView.builder(
        itemCount: events.length,
        itemBuilder: (ctx, i) => EventCard(
          event: events[i],
          onTap: () => context.push('/event/${events[i].eventCode}'),
        ),
      ),
    );
  }
  // ... similar builders for posts and highlights
}