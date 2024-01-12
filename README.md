# Court Booker App

Court Booker is a mobile application built with Flutter, designed specifically for tennis enthusiasts. It streamlines the process of booking and managing tennis court reservations. With a user-friendly interface and integration with Open Meteo for live weather updates, the app ensures users have a seamless and informative booking experience.

## Features

- **Court Reservations**: Provides a straightforward and engaging way for users to book tennis courts.
- **Weather Forecast Integration**: The app integrates with the Open Meteo API to provide users with up-to-date weather forecasts, including precipitation probabilities, so they can plan their tennis sessions with confidence.
- **User-Friendly Management**: A straightforward approach to view, book, and cancel reservations, enhancing user experience with simple navigation and interaction.
- **Local Data Management**: Utilizes local data storage to keep user reservations and settings, allowing for a personalized and consistent experience across sessions.
- **State Management**: The app leverages Flutter Bloc and Hydrated Bloc for state management, paired with go_router for smooth and intuitive navigation.
- **Clean Code Practices**: Dart extensions are used strategically to enhance code clarity and streamline functionality specific to certain data types.

## Testing

A rigorous suite of unit tests is included to verify the functionality of the Bloc components, which manage the business logic for booking and unbooking courts, as well as handling the serialization and deserialization of user data. Additional testing is provided for the WeatherBloc, which manages the API call states, ensuring the app's robustness in interacting with external weather data.
