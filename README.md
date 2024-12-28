# Weather App

A Flutter-based weather application that provides weather forecasts using data fetched from an
external API this weather data is fetched from [OpenWeatherMap](https://openweathermap.org/),
persisting data locally using SQLite, and implementing location-based services.

## Features

- **State Management & Dependency Injection**: Using `GetX` for efficient state management and
  dependency injection.
- **HTTP Client**: Utilizes `Dio` for API calls to fetch weather data.
- **Local Storage**: Data is persisted using `sqflite` for local storage and
  `flutter_secure_storage` for storing sensitive data securely.
- **Internationalization**: Supports multiple languages with the help of the `intl` package.
- **Location Services**: Automatically determines the user's location (latitude and longitude) using
  `geolocator` for personalized weather forecasts.
- **Weather Data Conversion**: Converts temperature from Celsius to Fahrenheit.
- **Forecast Display**: Displays a 5-day weather forecast with 3-hour interval data.
- **Clean Architecture**: Implemented using the MVVM (Model-View-ViewModel) pattern for scalable and
  maintainable code.

## Dependencies

This app uses the following dependencies:

### State Management & Dependency Injection

- `get: ^4.6.6` – State management and dependency injection.

### HTTP Client for API calls

- `dio: ^5.5.0+1` – HTTP client for API calls.

### Database and Storage

- `sqflite` – SQLite database support.
- `path_provider` – Provides access to device storage directories.
- `path` – Path manipulation utilities.

### Internationalization and Localization

- `intl: ^0.19.0` – Internationalization and localization support.
- `flutter_dotenv: ^5.1.0` – Manages environment variables for different configurations.

### Location Services

- `geolocator: ^13.0.2` – Provides access to the device's geolocation (latitude and longitude).
- `permission_handler` – Handles runtime permissions for location access.
- `url_launcher: ^6.1.12` – Launches URLs in the browser or other apps.
- `flutter_secure_storage: ^9.2.2` – Securely stores sensitive data like API keys or tokens.
- `connectivity_plus` – Monitors internet connectivity status.

### UI and UX

- `flutter_spinkit: ^5.2.1` – Provides various loading indicators.

## Architecture

The app follows **Clean Architecture** principles, organized into the following layers:

1. **Data Layer**:
    - Responsible for data retrieval and manipulation.
    - Includes classes like `WeatherDataDAO` for local data storage using SQLite (`sqflite`) and
      data fetch logic from the external API through `Dio`.
    - This layer deals with external data sources such as databases and APIs.

2. **Domain Layer**:
    - Defines the core business logic and entities, such as `WeatherDataClass`, and the interfaces
      for repositories.
    - Contains Use Cases that are responsible for executing business logic (such as fetching and
      transforming weather data).

3. **Presentation Layer**:
    - The UI components of the app, built with Flutter widgets.
    - Uses `GetX` for state management, which allows the UI to react to changes in the ViewModel.
    - The Presentation Layer consists of `Widgets` and `ViewModel` classes that manage the state and
      UI updates.

4. **Use Case Layer**:
    - Encapsulates specific tasks that the app needs to perform, such as fetching weather data,
      converting temperature, and determining the user's location.
    - Each use case implements a business rule, like fetching data from an API or manipulating data,
      and communicates with repositories or data sources.
    - For example, `GetWeatherDataUseCase` can be used to fetch weather data, process it, and
      deliver the results to the ViewModel.

5. **Repository Pattern**:
    - The **Repository** serves as the single source of truth for the app's data.
    - It abstracts the data sources, so the domain layer doesn't need to know if data comes from an
      API, a database, or another source.
    - The `WeatherRepository` fetches data either from the local database (`WeatherDataDAO`) or from
      the API, depending on the situation.

### Example Flow:

1. **Presentation Layer**:
    - The UI (Widgets) interacts with the `ViewModel`.
    - The `ViewModel` uses `GetX` controllers to manage state and triggers the execution of **Use
      Cases**.
    - dependency injection

2. **Use Case Layer**:
    - The `UseCase` interacts with the `Repository` to fetch or manipulate data.

3. **Repository Layer**:
    - The `Repository` interacts with the **Data Layer** (API or Database) to fetch and store data.

4. **Data Layer**:
    - Fetches data from external APIs or databases and returns the data to the repository.

## Features Implementation

### Location Services

The app automatically determines the user's location using the `geolocator` package. It fetches the
latitude and longitude and uses it to request the weather forecast for that location.

### Weather Data Conversion

The app fetches weather data in Celsius and provides an option to display it in Fahrenheit.

### Forecast for 5 Days

The app displays a 5-day weather forecast, with data at 3-hour intervals, including temperature,
humidity, pressure, and weather conditions.

### Persisted Data

Weather data is stored in a local SQLite database using `sqflite` for offline access and quick
retrieval. Sensitive data like API keys are stored securely using `flutter_secure_storage`.

###

using .env file to secure base url and api key.

## Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/Tanzir-Ratul/weather_app.git
