# Cinemapedia App

Cinemapedia is a Flutter application that provides information about movies, including details such as ratings, reviews, and trailers. The app fetches data from a movie database API and presents it in a user-friendly interface.

## Features

- Browse popular, top-rated, and upcoming movies
- Search for movies by title
- View detailed information about each movie, including cast, crew, and reviews
- Save favorite movies for quick access

## Installation

To run this project locally, follow these steps:

1. Clone the repository:
    ```bash
    git clone https://github.com/yourusername/cinemapedia_app.git
    ```
2. Navigate to the project directory:
    ```bash
    cd cinemapedia_app
    ```
3. Install dependencies:
    ```bash
    flutter pub get
    ```
4. Create the `.env` file using `.env.template`:

5. Run the riverpod compiler:
    ```bash
    dart run build_runner watch
    ```
6. Run the app:
    ```bash
    flutter run
    ```

## API

This app uses the [The Movie Database (TMDb) API](https://www.themoviedb.org/documentation/api) to fetch movie data. You will need to sign up for an API key and add it to your project.

# Splash screen
Yhis app uses the [flutter_native_splash](https://pub.dev/packages/flutter_native_splash) package to generate the splash screen. You can make changes in the `flutter_native_splash.yaml` file. 

After making your changes to `flutter_native_splash.yaml`, run the following command in the terminal:

```
dart run flutter_native_splash:create --path=flutter_native_splash.yaml
```

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request with your changes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact

If you have any questions or feedback, feel free to reach out to me at [bryantorresckp@gmail.com](mailto:bryantorresckp@gmail.com).
