# School Survey Assessment - Flutter App

## Overview
This Flutter application is developed as a school survey assessment task given by a company. It features a persistent `NavigationRail`-based sidebar that dynamically updates based on user input. The app allows users to add school-related tabs, each containing a unique form. Once validated, school data is appended to a separate state list.

## Features
- **Persistent NavigationRail Sidebar**: The first tab is always "General," while additional tabs are dynamically created based on the number of schools entered by the user.
- **Dynamic Forms**: Each school tab contains a distinct form with a unique key.
- **State Management with Riverpod**: Validated school data is stored in a separate state list upon pressing the 'Next' button, managed efficiently using Riverpod.

## Installation
1. Clone this repository: (Optional)
   ```sh
   git clone https://github.com/ab-irami/school-survey.git
   ```
2. Navigate to the project directory:
   ```sh
   cd school-survey
   ```
3. Install dependencies:
   ```sh
   flutter pub get
   ```
4. Run the app:
   ```sh
   flutter run
   ```

## Technologies Used
- **Flutter**
- **Dart**
- **State Management**: Riverpod

## Project Structure
- **controllers/survey** - Logic related to surveys
- **controllers/school_data** - Logic related to school data
- **repositories/surveys** - CRUD operations for surveys
- **providers/state_providers** - Overall state management
- **models** - Contains all models
- **views/auth** - Sign-in and sign-up screens
- **views/surveys** - Add survey and survey commencement screens
- **views/home** - Home screen dashboard
- **views/utils/splash** - Initial splash screen
- **utils** - Common extensions, widgets, and app themes
- **routes** - Application routes

