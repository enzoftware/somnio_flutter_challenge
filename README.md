
# Flutter Blog App (Riverpod Coding Challenge)

This project is a Flutter application that displays a list of blog posts fetched from the JSONPlaceholder API. The app uses Flutter's Material Design components and integrates the **Riverpod** state management library for managing application state.

## Prerequisites

Before running the project, ensure you have the following installed:

- [Flutter SDK 3.22](https://flutter.dev/docs/get-started/install)
- [Dart SDK 3.4](https://dart.dev/get-dart)
- A device or emulator to run the app

## Setup Instructions

1. **Clone the repository**:

    ```bash
    git clone https://github.com/enzoftware/somnio_flutter_challenge.git
    cd somnio_flutter_challenge
    ```

2. **Install dependencies**:

    After navigating to the project directory, run:

    ```bash
    flutter pub get
    ```

3. **Run the project**:

    To run the project on a connected device or emulator:

    ```bash
    flutter run
    ```

## Features

- Fetches and displays blog posts from the JSONPlaceholder API.
- Implements infinite scroll for loading more posts as the user scrolls down.
- Includes a tab bar with two tabs:
  - **First Tab**: Displays the blog posts.
  - **Second Tab**: Unimplemented Favorites blogs.
- The tab bar remains pinned at the top while scrolling.
- The app utilizes **Riverpod** for state management.

## Testing

To run unit and widget tests for the project, use the following command:

```bash
flutter test
```

## Architecture

The project follows the **Clean Architecture** principles to ensure scalability and maintainability.

### State Management

- The app uses **Riverpod 2.5.1** to manage state across the application. Riverpod helps in keeping the app modular and testable.

### Folder Structure

- `lib/features/blog_list`: Contains the presentation and logic for the blog list.
- `lib/widgets`: Contains reusable UI components.
- `lib/core`: Core utilities used across the project.

## Bonus

- Unit tests are implemented for key components of the application.

## API Used

The app fetches blog posts from the following API:

- [JSONPlaceholder](https://jsonplaceholder.typicode.com/posts)

## Contact

In case of any issues or questions, feel free to reach out:

- [lizama.enzo@gmail.com](mailto:lizama.enzo@gmail.com)
