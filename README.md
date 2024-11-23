# Gym Management Mobile App (Flutter + Firebase)

This Flutter project is a mobile application designed to handle gym operations using Firebase as the backend. The app supports two types of users: trainers and participants, with additional features for an admin panel to manage equipment, gym schedules, and membership approvals.

## Features

### User Roles:
- **Trainer**: Can create gym classes for participants to join.
- **Participant**: Can manage memberships and join classes if their membership is active.
- **Admin**: Can manage equipment, job opportunities, schedules, and approve/reject pending memberships and classes.

### Key Features:
- **User Profiles**: Each user (trainer or participant) has a personal profile.
- **Gym Classes**: Trainers can create gym classes for participants to browse and join.
- **Gym Equipment**: Users can browse a list of available gym equipment.
- **Job Opportunities**: Users can view available job openings at the gym.
- **Gym Schedule**: Users can see the gym's operational hours and any scheduled holidays or closures.
- **Membership Management**: Participants can request memberships, and admins can approve or reject these requests.
- **Admin Panel**: Admins can:
  - Add gym equipment.
  - Post job opportunities.
  - Manage gym schedules (including adding holidays).
  - Approve or reject gym classes and memberships.

## Tech Stack

- **Flutter**: Frontend for building the mobile application.
- **Firebase**: Backend services including authentication, Firestore database, and real-time updates.
  - **Firebase Authentication**: For handling user logins and roles (trainer, participant, admin).
  - **Firebase Firestore**: For storing gym classes, equipment, job listings, and membership data.
  - **Firebase Storage**: For storing user profile images or gym-related media (if applicable).

## Prerequisites

- **Flutter SDK**: Ensure you have Flutter installed.
- **Firebase Project**: Set up a Firebase project for backend services.
- **Firebase CLI**: Install the Firebase CLI to manage Firebase services.

## Setup Instructions

1. **Clone the repository**:
    ```bash
    git clone https://github.com/Hayan47/Gym-App.git
    cd Gym-App
    ```

2. **Install dependencies**:
    ```bash
    flutter pub get
    ```

3. **Firebase Setup**:
    - Go to the [Firebase Console](https://console.firebase.google.com/).
    - Create a Firebase project.
    - Add an Android and iOS app to your project.
    - Download the `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) files and place them in the appropriate folders in your Flutter project:
        - `android/app/google-services.json`
        - `ios/Runner/GoogleService-Info.plist`
    - Enable **Firebase Authentication** and add the following providers: Email/Password (for basic user login).

4. **Firestore Database Setup**:
    - Go to the Firebase Console.
    - Enable Firestore and create collections for:
      - `users`: To store user profiles (trainers, participants, admin).
      - `gym_class`: For storing class details created by trainers.
      - `equipment`: For listing available equipment.
      - `schedule`: To manage gym opening hours and holidays.
      - `jobs`: To list available jobs.


5. **Run the app**:
    - Run the app on a connected device or simulator:
    ```bash
    flutter run
    ```

## App Structure

- **Authentication**: Users can sign up or log in with their role (trainer, participant, admin).
- **Profile**: Users can view and edit their profile.
- **Gym Classes**: Trainers can create classes, and participants can browse and join classes.
- **Gym Equipment**: Users can browse a list of available gym equipment.
- **Job Opportunities**: View available job openings at the gym.
- **Schedule**: Users can view gym opening hours and holidays.

### Admin Panel:
- **Add Equipment**: Admins can add gym equipment.
- **Manage Job Opportunities**: Admins can post new job openings.
- **Manage Memberships**: Admins can view pending membership requests and approve or reject them.
- **Class Approvals**: Admins can see pending classes and accept or reject them.
- **Schedule Management**: Admins can add holidays or adjust gym schedules.

### ScreenShots:
<p align="center">
  <img src="https://github.com/Hayan47/Hayan47/blob/main/gym3.jpg" width="30%" />
  <img src="https://github.com/Hayan47/Hayan47/blob/main/gym2.jpg" width="30%" />
  <img src="https://github.com/Hayan47/Hayan47/blob/main/gym1.jpg" width="30%" />
</p>
