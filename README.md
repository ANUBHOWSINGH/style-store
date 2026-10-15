# Style Store — Flutter E-Commerce App

A Flutter-based clothing shopping application developed as part of a Flutter Developer technical assessment.

## Features

- **Login:** Email and password validation with dummy authentication.
- **Product Listing:** Browse clothing products loaded from local JSON.
- **Watchlist:** Add and remove favourite products with synchronized state.
- **Shopping Cart:** Add and remove products, update quantities, and calculate totals dynamically.
- **Dummy Checkout:** View the order summary and simulate payment processing.
- **Payment Success:** Display a generated order ID and paid amount.
- **Error Handling:** Handle validation failures and application errors.
- **Unit Testing:** Tests for important business logic.

## Tech Stack

- Flutter and Dart
- flutter_bloc — state management
- Clean Architecture
- Repository Pattern
- Local JSON data source
- In-memory cart and watchlist storage

## Architecture

The project separates presentation, business logic, and data access.

```text
lib/
├── core/
├── features/
│   ├── auth/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── products/
│   ├── watchlist/
│   ├── cart/
│   └── payment/
└── main.dart
```

The exact folders may vary depending on the implementation.

### Architecture Layers

- **Presentation:** Screens, reusable widgets, BLoC events, states, and UI updates.
- **Domain:** Business rules, use cases, and repository interfaces.
- **Data:** Repository implementations, local JSON access, and in-memory data sources.

### State Management

BLoC handles application state using explicit events and states.

Examples of operations include login submission, product loading, watchlist updates, cart quantity changes, and payment processing.

### Data Storage

- Products are loaded from a local JSON file.
- Cart and watchlist data use in-memory storage.
- No backend, database, or real payment gateway is required for this assessment.

## Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK compatible with the project
- Android Studio or Visual Studio Code

### Installation

Clone the repository:

```bash
git clone https://github.com/ANUBHOWSINGH/style-store.git
cd style-store
```

Install dependencies:

```bash
flutter pub get
```

Run the application:

```bash
flutter run
```

## Testing

Run unit tests:

```bash
flutter test
```

Run static analysis:

```bash
flutter analyze
```

## Project Requirements

- Flutter and Dart
- Clean Architecture
- BLoC with events and states
- Dedicated use cases and repository abstractions
- Strongly typed Dart models
- Local JSON product data
- Minimum three unit tests

## Assessment Submission

- **GitHub Repository:** https://github.com/ANUBHOWSINGH/style-store
- **Project:** E-Commerce Clothing Application
- **Purpose:** Flutter Developer Technical Assessment

## Author

**ANUBHOWSINGH**

Developed using Flutter and Dart.