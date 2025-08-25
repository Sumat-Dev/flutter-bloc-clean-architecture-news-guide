import '../models/article_model.dart';

class ArticlesMockDataSource {
  static List<ArticleModel> getMockArticles() {
    return [
      ArticleModel(
        id: '1',
        title: 'Flutter 3.24 Released with Performance Improvements',
        description:
            'Flutter 3.24 brings new rendering optimizations, faster builds, and better DevTools. This release focuses on improving the developer experience and app performance.',
        url: 'https://flutter.dev/blog/flutter-3-24',
        urlToImage: 'https://picsum.photos/id/235/400/200',
        publishedAt: DateTime(2025, 1, 20, 10, 0, 0),
        sourceName: 'Flutter Blog',
      ),
      ArticleModel(
        id: '2',
        title: 'Dart 3.4 Announced with New Language Features',
        description:
            'Dart introduces records, pattern matching, and enhanced async features. These improvements make Dart more powerful and expressive for modern development.',
        url: 'https://dart.dev/dart-3-4',
        urlToImage: 'https://picsum.photos/id/236/400/200',
        publishedAt: DateTime(2025, 1, 18, 8, 30, 0),
        sourceName: 'Dart Team',
      ),
      ArticleModel(
        id: '3',
        title: 'AI in Mobile Development: Trends 2025',
        description:
            'AI tools like ChatGPT are transforming how developers build apps. Learn about the latest trends and how to integrate AI into your mobile development workflow.',
        url: 'https://technews.ai/ai-in-mobile',
        urlToImage: 'https://picsum.photos/id/237/400/200',
        publishedAt: DateTime(2025, 1, 15, 14, 15, 0),
        sourceName: 'TechNews',
      ),
      ArticleModel(
        id: '4',
        title: 'Clean Architecture Best Practices for Flutter',
        description:
            'Learn how to implement Clean Architecture in Flutter apps for better maintainability, testability, and scalability. Follow SOLID principles and separation of concerns.',
        url: 'https://flutter.dev/architecture',
        urlToImage: 'https://picsum.photos/id/238/400/200',
        publishedAt: DateTime(2025, 1, 12, 16, 45, 0),
        sourceName: 'Flutter Community',
      ),
      ArticleModel(
        id: '5',
        title: 'State Management with Bloc: Complete Guide',
        description:
            'Master the Bloc pattern for state management in Flutter. Understand events, states, and how to build reactive, maintainable applications.',
        url: 'https://bloclibrary.dev/guide',
        urlToImage: 'https://picsum.photos/id/239/400/200',
        publishedAt: DateTime(2025, 1, 10, 11, 20, 0),
        sourceName: 'Bloc Library',
      ),
    ];
  }
}
