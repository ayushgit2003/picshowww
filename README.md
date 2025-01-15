# Picshow

Picshow is a Flutter-based image gallery application that fetches and displays images from a remote API. It is designed with clean architecture principles, using Bloc for state management, ensuring scalability and maintainability. The app implements features like caching, zooming, infinite scrolling (pagination), and robust error handling.

---

## Introduction

Picshow is a feature-rich image gallery application demonstrating best practices in Flutter app development. Key highlights include:

- Displays a grid of images fetched from a remote API.
- Allows full-screen image zooming and panning.
- Uses efficient caching to minimize redundant network calls.
- Smooth infinite scrolling for loading additional images.
- Comprehensive error handling for network issues and API failures.
- Built with modular, reusable, and scalable architecture.

---

## Features

### Caching

- **Custom Cache Management**: Implements a custom caching mechanism using the `flutter_cache_manager` package.
- **Local Storage**: Images are stored locally to avoid redundant network requests.
- **Cache Expiry**: Configurable expiration time (default: 3 minutes).
- **Disk Space Management**: Automatically clears old cache files to save storage.

### Clean Architecture

Picshow is built on clean architecture principles with the following layers:

- **Data Layer**: Handles API interactions and caching.
- **Domain Layer**: Encapsulates business rules and communicates with the data layer.
- **Presentation Layer**: Manages UI rendering and user interactions via Bloc.
- **State Management**: Uses Bloc to ensure a unidirectional data flow.
- **Dependency Injection (DI)**: Injects dependencies using `GetIt`, making the app modular and testable.

### Zooming

- Full-screen images support zooming and panning using Flutter's `InteractiveViewer`.
- Configured to allow smooth interaction with maximum zoom set to 10x.

### Pagination

- Implements infinite scrolling using `ScrollController`.
- Automatically fetches more images as the user scrolls down.
- Displays a loading indicator at the bottom during data fetch.

---

## Edge Cases Handled

1. **Network Failures**: Displays a fallback UI (e.g., "No Internet Connection") when the app cannot fetch data.
2. **Slow Loading**: Shows a `CircularProgressIndicator` while fetching data or loading images.
3. **Empty Responses**: Handles cases where the API returns no images with an appropriate message.
4. **Caching Failures**: Gracefully falls back when cached data is unavailable.
5. **Zoom Limits**: Prevents users from excessively zooming in or out of images.

---

## How to Set Up the Project Locally

Follow these steps to set up the project on your local machine:

### 1. Prerequisites

Ensure the following are installed:
- Flutter SDK (latest stable version)
- Git

### 2. Clone the Repository

 
git clone https://github.com/ayushgit2003/picshowww
cd picshowww


### 3. Install Dependencies

Run the following command to install the required Flutter dependencies:

 
flutter pub get

### 4. Run the Application

Start the app by running:

```bash
flutter run

