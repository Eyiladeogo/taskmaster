# TaskMaster Mobile App

A simple, intuitive, and mobile-friendly Task Manager application built with Flutter.

## Table of Contents
- [Project Overview](#project-overview)
- [Features](#features)
- [Technology Stack](#technology-stack)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)

## Project Overview
TaskMaster is a mobile application designed to help users manage their daily tasks efficiently and stay organized.

## Features
The application implements the following core user stories:

- **User Authentication:** Users can register new accounts and log in. (Note: Authentication is simulated using local storage for prototyping purposes).
- **Task Management (CRUD):**
  - **Create:** Users can add new tasks with a title, description, and optional due date.
  - **Edit:** Users can modify existing tasks.
  - **Delete:** Users can remove tasks.
- **Task Completion:** Users can mark tasks as completed or uncompleted.
- **Personalized View:** Users can only view their own tasks.
- **Task Filtering:** Tasks can be filtered by "All Tasks", "Completed", and "Pending" status.
- **Password Visibility Toggle:** A convenient eye icon allows users to show or hide their password input.

## Technology Stack
- **Mobile Framework:** Flutter (Dart)
- **Backend/Data Storage:** Local Storage (`shared_preferences` package)
- **State Management:** `setState` and built-in Flutter mechanisms (e.g., `TabController`)
- **Authentication Method:** Simulated via local storage
- **Dependency Management:** `pubspec.yaml`
  - `uuid`: For generating unique IDs for tasks
  - `shared_preferences`: For local data persistence

## Project Structure
```
project-root/
├── lib/
│   ├── main.dart                  # Main application entry point and theme definition
│   ├── models/
│   │   └── task.dart              # Data model for tasks
│   ├── screens/                   # UI screens of the application
│   │   ├── welcome_screen.dart
│   │   ├── login_screen.dart
│   │   ├── register_screen.dart
│   │   ├── my_tasks_screen.dart
│   │   └── add_edit_task_screen.dart
│   ├── services/                  # API calls or backend integration
│   │   └── local_storage_service.dart # Handles data persistence to local storage
│   └── widgets/                   # Reusable UI components
│       └── text_link.dart         # Custom widget for text-based links
└── README.md                      # This file
```

## Getting Started
Follow these instructions to get a copy of the project up and running on your local machine.

### Prerequisites
- Flutter SDK installed and configured
- Android Studio (for Android emulator/device support) or VS Code with Flutter/Dart extensions
- A physical Android device with USB Debugging enabled or an Android Emulator setup

### Installation
Clone the repository:
```bash
git clone https://github.com/your-username/taskmaster.git
cd taskmaster
```
Get Flutter dependencies:
```bash
flutter pub get
```

### Running the App
Connect a device or launch an emulator:
- Ensure your Android device is connected via USB with debugging enabled, or an Android emulator is running.

Verify device detection:
```bash
flutter devices
```
(You should see your device/emulator listed.)

Run the application:
```bash
flutter run
```
The app will build and launch on your selected device/emulator.

## Thought Process & Design Choices
My primary thought process revolved around creating a clean, intuitive, and highly functional user experience while adhering strictly to the project requirements.

- **Framework Choice (Flutter):** Having prior Flutter experience, and wanting to build a robust cross-platform app efficiently, Flutter was the natural choice. Its reactive UI paradigm aligns well with modern mobile development.
- **Local Storage as Backend:** For the "simple Task Manager" requirement, opting for local storage (`shared_preferences`) was a deliberate choice to simplify the project scope, reduce external dependencies, and allow for rapid prototyping and iterative development. This allowed me to focus heavily on the frontend logic and UI without getting bogged down by backend complexities.
- **Authentication Simulation:** Since a full backend was not implemented, user registration and login are simulated using local storage. This fulfills the user story of allowing users to "register and log in" and "view only my own tasks" by associating tasks with a logged-in state.
- **State Management (`setState`):** For a project of this scale, `setState` combined with a clear separation of concerns (e.g., `LocalStorageService`) proved sufficient for managing UI state. For larger applications, I would consider Provider or Bloc for more complex state needs.
- **Code Structure:** Adhering to the suggested project structure (screens, components, services, models) ensured good code organization, readability, and maintainability, making it easier to scale or debug.
- **Error Handling & User Feedback:** Basic validation (e.g., password mismatch) and user feedback (Snackbars, error messages on empty task lists) were integrated for a better user experience.

## Limitations & Future Improvements
Given more time, the following features and improvements would be prioritized:
- **Robust Authentication:** Integrate a proper authentication solution like Firebase Authentication or a custom Node.js/Express backend with JWT for secure user management.
- **Advanced State Management:** Migrate to a more scalable state management solution like Provider, Riverpod, or Bloc for more complex application states.
- **Persistent User Sessions:** Implement proper session management beyond simple local flags.
- **Date Picker Refinements:** Allow clearing the due date.
- **Task Sorting:** Add options to sort tasks by due date, creation date, or alphabetical order.
- **Categories/Tags:** Allow users to categorize tasks.
- **Search Functionality:** Enable searching through tasks.
- **Input Validation:** More comprehensive form validation for all input fields.
- **Error Handling:** More user-friendly error messages and robust error handling.
- **Unit & Widget Testing:** Implement a comprehensive suite of tests to ensure code reliability and prevent regressions.
- **Animations & Transitions:** Add subtle animations for a more polished feel.
- **Push Notifications:** For due date reminders.
- **Theming:** Allow users to choose different themes (light/dark mode).
