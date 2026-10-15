# Style Store  Application

Hi! This is my Flutter e-commerce clothing app project. I built it as part of a Flutter Developer Technical Assessment.

The main goal of this project was to create a simple shopping app and understand how to manage the app's business logic separately from the UI using BLoC and Clean Architecture.

## What I have built

- **Login:** Email and password login with validation and demo credentials.
- **Products:** A clothing product list loaded from a local JSON file.
- **Watchlist:** Users can add their favourite products and remove them whenever they want.
- **Cart:** Users can add products, remove them, and increase or decrease quantities.
- **Price calculation:** The cart total and item count update automatically.
- **Checkout:** Shows the products, quantities, and total amount before payment.
- **Dummy payment:** Simulates payment, generates an order ID, and shows a success screen.
- **Error and empty states:** Added feedback for situations such as an empty cart or failed product loading.

## Technologies I used

- Flutter
- Dart
- BLoC (`flutter_bloc`)
- Equatable
- GetIt for dependency injection
- UUID for generating demo order IDs
- Flutter Test for unit testing

## How I organised the code

I tried to keep the UI and business logic separate so the code is easier to understand, maintain, and test.

The project is organised into feature folders. Each main feature has its own layers.

- **Presentation:** Screens, widgets, BLoC events, and states.
- **Domain:** Entities, repository contracts, and use cases.
- **Data:** Repository implementations, local data sources, and JSON parsing.

The basic flow is:

`UI → BLoC → Use Case → Repository → Data Source`

For example, when a user adds a product to the cart, the UI sends an event to the Cart BLoC. The BLoC calls the appropriate use case, which works through the repository to update the cart data.

I have used GetIt to register dependencies so that the different layers can work together without creating their dependencies directly inside the UI.

## Login credentials

You can use these credentials to test the login screen:

- **Email:** `demo@stylestore.com`
- **Password:** `Style@123`

These are demo credentials only. The project uses local dummy authentication, not a real authentication server.

## How to run the project

Make sure Flutter is installed on your system.

1. Clone the repository:

   ```bash
   git clone YOUR_GITHUB_REPOSITORY_URL
   ```

2. Open the project folder:

   ```bash
   cd style_store
   ```

3. Install the dependencies:

   ```bash
   flutter pub get
   ```

4. Run the app:

   ```bash
   flutter run
   ```

## How to run the tests

I have added tests for cart calculations, Watchlist operations, and login authentication.

Run the tests with:

```bash
flutter test
```

To check the code for analysis issues, run:

```bash
flutter analyze
```

## A few things to know

- The product list comes from a local JSON file.
- Cart and Watchlist data are stored in memory, so they may reset when the app process restarts.
- Payment is simulated. No real money is charged.
- Product images may need an internet connection.

## What I learned

While working on this project, I got practical experience with BLoC, Clean Architecture, dependency injection, repository patterns, use cases, and unit testing.

I also learned why keeping business logic separate from UI code makes an application easier to maintain and test.

## Thank you

Thank you for reviewing my project. I hope the code structure and implementation demonstrate my understanding of Flutter development and application architecture.
