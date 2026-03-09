# Flutter Testing — BLoC Dashboard

A modern, scalable Flutter dashboard application built using **Feature-Based Architecture**, **BLoC Pattern** for state management, and **Dio** for robust networking.

## Features

- **Dynamic Weather Integration**: Fetches real-time weather data for Colombo, Sri Lanka, utilizing the free Open-Meteo API.
- **Live Cricket Scores**: Integrates with the Cricbuzz API via RapidAPI to display a live feed of ICC cricket matches, elegantly separated into Live, Upcoming, and Recent categories.
- **Smart UI Rendering**: Employs `CustomScrollView` and `SliverMainAxisGroup` to create a beautiful, performant scrolling experience. Includes responsive badges for Match Formats (TEST, T20, ODI) and active match statuses (LIVE, UPCOMING).
- **Graceful Loading States**: Utilizes the `shimmer` package paired with atomic widget design to create a smooth layout loading experience prior to network resolutions.
- **Intelligent Networking**: Incorporates a custom Dio `RateLimitInterceptor` to prevent spamming APIs and manages sensitive endpoints securely using `flutter_dotenv`.

## Architecture Overview

The app rigidly follows a Feature-Based breakdown, ensuring separation of concerns:

- **Core Layer** (`lib/src/core/`)
  - `network/`: Contains `DioClient` with built-in logging (`PrettyDioLogger`) and rate-limiting.
- **Home Feature** (`lib/src/features/home/`)
  - `data/`: Models (e.g. `weather_model.dart`, `match_model.dart`) and Services (`weather_api_service.dart`, `match_api_service.dart`).
  - `logic/`: BLoCs managing state transitions via Events and States (`WeatherBloc`, `MatchBloc`).
  - `presentation/`: Atomic UI widgets (`weather_card.dart`, `match_tile.dart`) and Screens (`home_screen.dart`).
- **Shared Layer** (`lib/src/shared/`)
  - Reusable UI elements (`custom_shimmer.dart`, `custom_circular_loader.dart`) used across the application.

## Getting Started

### Prerequisites

- Flutter SDK (3.0+)
- Dart (3.0+)
- A RapidAPI account

### 1. Environment Configuration

The application requires API keys to function securely.

1. Create a `.env` file at the root of the project based on the provided `.env.example`.
2. Subscribe to the **Cricbuzz Cricket API** on RapidAPI.
3. Paste the provided access key into the `RAPID_API_KEY` variable.

```env
WEATHER_API_URL=https://api.open-meteo.com/v1/forecast
WEATHER_LAT=6.9271
WEATHER_LON=79.8612
RAPID_API_KEY=your_cricbuzz_rapid_api_key_here
```

### 2. Installation

Install all required pub dependencies:

```bash
flutter pub get
```

### 3. Running the Application

Boot up your desired iOS simulator or Android emulator and run:

```bash
flutter run
```

## Packages Used

- `flutter_bloc` & `equatable` — Standardized State Management
- `dio` & `pretty_dio_logger` — Network Client & Debugging
- `flutter_dotenv` — API Credential Security
- `intl` — Date & Time formatting (SLST conversions)
- `shimmer` — Skeleton UI Loaders
