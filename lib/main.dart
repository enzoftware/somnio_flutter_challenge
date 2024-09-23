import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:somnio_flutter_challenge/core/core.dart';
import 'package:somnio_flutter_challenge/core/providers/providers.dart';

import 'features/blog_list/presentation/view/blog_list_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(SomnioBlogApp(sharedPreferences: sharedPreferences));
}

class SomnioBlogApp extends StatelessWidget {
  const SomnioBlogApp({super.key, required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SomnioBlogApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(sharedPreferences),
        ],
        observers: [
          SomnioBlogObserver(),
        ],
        child: const BlogHomePage(),
      ),
    );
  }
}

class BlogHomePage extends HookConsumerWidget {
  const BlogHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> tabs = <String>['News', 'Favorites'];
    final scrollController = useScrollController();

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        body: PrimaryScrollController(
          controller: scrollController,
          child: NestedScrollView(
            controller: scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  centerTitle: true,
                  title: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      children: [
                        Text(
                          'Somnio Blog',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Dive into stories that stick!',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  floating: true,
                  pinned: true,
                  expandedHeight: 130.0,
                  forceElevated: innerBoxIsScrolled,
                  bottom: TabBar(
                    tabs: tabs.map((String name) => Tab(text: name)).toList(),
                  ),
                ),
              ];
            },
            body: const TabBarView(
              children: [
                BlogListView(),
                Placeholder(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
