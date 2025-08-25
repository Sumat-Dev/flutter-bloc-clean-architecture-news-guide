# News App - Flutter Bloc Clean Architecture

A modern News App built with Flutter using Bloc state management and Clean Architecture principles.

## 🏗️ Architecture Overview

This project follows Clean Architecture principles with a clear separation of concerns:

```bash
lib/
├── core/                           # Core functionality
│   ├── common/                     # Common widgets and utilities
│   │   └── views/
│   │       └── page_under_construction.dart
│   ├── config/                     # App configuration
│   │   └── app_config.dart
│   ├── di/                         # Dependency injection
│   │   └── service_locator.dart
│   ├── error/                      # Error handling
│   │   ├── exceptions.dart
│   │   └── failures.dart
│   ├── network/                    # Network layer
│   │   └── dio_client.dart
│   ├── usecase/                    # Use case interfaces
│   │   └── usecase.dart
│   ├── utils/                      # Utility types and helpers
│   │   └── typdefs.dart
│   └── theme/                      # App theming
│       └── app_theme.dart
├── features/                       # Feature modules
│   └── articles/                   # Articles feature
│       ├── data/                   # Data layer
│       │   ├── datasources/
│       │   │   ├── articles_remote_data_source.dart
│       │   │   └── articles_local_data_source.dart
│       │   ├── models/
│       │   │   └── article_model.dart
│       │   └── repositories/
│       │       └── article_repository_impl.dart
│       ├── domain/                 # Domain layer
│       │   ├── entities/
│       │   │   └── article.dart
│       │   ├── repositories/
│       │   │   └── article_repository.dart
│       │   └── usecases/
│       │       └── get_top_headlines.dart
│       └── presentation/           # Presentation layer
│           ├── bloc/
│           │   ├── articles_bloc.dart
│           │   ├── articles_event.dart
│           │   └── articles_state.dart
│           ├── pages/
│           │   └── articles_page.dart
│           └── widgets/
│               ├── article_tile.dart
│               └── state_views.dart
├── router/                         # Navigation
│   └── app_router.dart
└── main.dart                       # App entry point
```

## 🛠️ Dependencies

### State Management

```yaml
flutter_bloc: ^8.1.4
bloc: ^8.1.4
```

### Network & HTTP

```yaml
dio: ^5.4.3
internet_connection_checker: ^1.0.0+1
```

### Local Storage

```yaml
shared_preferences: ^2.2.2
```

### Dependency Injection

```yaml
get_it: ^7.7.0
```

### Utilities

```yaml
equatable: ^2.0.5
dartz: ^0.10.1
url_launcher: ^6.2.5
```

### Development

```yaml
build_runner: ^2.4.8
json_serializable: ^6.8.0
```

## 🏗️ Architecture

### Clean Architecture Layers

**Domain Layer** - Business logic and entities

- Pure Dart classes with no dependencies
- Business entities and use cases
- Repository interfaces

**Data Layer** - Data sources and implementations

- Remote data sources (API calls)
- Local data sources (caching)
- Repository implementations
- Data models

**Presentation Layer** - UI and state management

- Bloc for state management
- UI components and pages
- Event-driven architecture

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

...

***If you find this project helpful, please give it a ⭐️ star!***
