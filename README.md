# Currency Converter App

## Overview

The Currency Converter App is a simple and intuitive application built with Flutter 3.19.2. This app allows users to convert an amount from one currency to multiple other currencies using real-time exchange rates fetched from an API. The app follows the Model-View-ViewModel (MVVM) architecture pattern and utilizes the Provider package for state management.

## Features
- Convert an amount from one currency to multiple other currencies.
- Add new currency converters.
- Delete existing currency converters using swipe actions.
- Switches between dark and light themes based on system settings for a personalized look.

## Key Benefits of MVVM for Currency Converters

### Clear Separation of Concerns

- **Model**: Represents currency data, conversion logic, and API interactions.
- **View**: Handles the user interface and user interactions.
- **ViewModel**: Acts as an intermediary, exposing data from the Model to the View and handling UI-related logic.

### Easier Testing

MVVM simplifies testing because the business logic is separate from the user interface.

### Maintaning

MVVM keeps the code for the currency converter app organized and easy to manage. It can be update the data or conversion logic without affecting the user interface. This separation makes it simpler to maintain and update the app as exchange rates or conversion methods change over time.

### UI Updates

MVVM is like having smart appliances. When you change the amount and country that needed to convert, the calculation result automatically adjusts with UI changes. 

### Complex UIs

As currency converter apps can have multiple input fields, conversion results, and additional features, MVVM helps manage the complexity by breaking down the UI into smaller, manageable components.

## Getting Started

### Prerequisites

- [Flutter SDK 3.19.2](https://flutter.dev/docs/get-started/install)
- [Dart SDK 3.3.0](https://dart.dev/get-dart)
- 
### Installation
1. **Clone the repository**:
   ```sh
   git clone https://github.com/himashagunasena/Currency_Converter_App.git

2. **Install dependencies**:
   ```bash
   flutter pub get

3. **Run App**:
   ```bash
   flutter run

## Contact

For any inquiries, please contact himasha.gunasena123@gmail.com.
