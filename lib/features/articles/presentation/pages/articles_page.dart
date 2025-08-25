import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/articles_bloc.dart';
import '../widgets/state_views.dart';

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({super.key});

  @override
  State<ArticlesPage> createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  @override
  void initState() {
    super.initState();
    // Load articles when the page is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ArticlesBloc>().add(const LoadTopHeadlines());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<ArticlesBloc>().add(const RefreshTopHeadlines());
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<ArticlesBloc>().add(const RefreshTopHeadlines());
        },
        child: BlocBuilder<ArticlesBloc, ArticlesState>(
          builder: (context, state) {
            return StateViews.buildView(context, state);
          },
        ),
      ),
    );
  }
}
