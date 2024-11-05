# ArtHive App

## Overview

ArtHive is a Flutter application designed for artists to showcase their artworks, manage their portfolios, and engage with a community of art enthusiasts. The app integrates Firebase for data management, user authentication, and real-time updates. It features a user-friendly interface, supports data segmentation, and ensures secure and personalized user experiences.

## Features

### User Profile Management
- **Local Storage:** User data, including name and email, is stored locally using Shared Preferences.
- **Firebase Data Segmentation:** Each user’s data is segmented based on their email in Firebase Realtime Database, ensuring data isolation and privacy.

### Data Management
- **Add Artwork:** Users can add new artworks with details such as title, artist name, description, price, and art style.
- **Update Artwork:** Users can update the details of their previously added artworks.
- **Delete Artwork:** Users can delete their artworks with a confirmation dialog.
- **View Artwork:** Artworks are displayed in a list, and clicking on an item shows detailed information.

### Database Integration
- **Firebase Realtime Database:** Used for storing and retrieving user-specific data such as user profiles, segmented by email to ensure privacy and data isolation.
- **Firestore Database:** Used for storing and managing artwork data. This includes details like title, artist name, description, price, and art style. Firestore provides scalable and real-time data synchronization, ensuring all users see the latest updates.
- **Firestore Storage:** Used for storing profile images and artwork images. Images are uploaded to Firestore Storage, and their URLs are saved in the corresponding Firestore document, allowing for efficient image retrieval and display.
- **Data Conversion:** Efficiently handles data conversion between JSON and Dart objects.

### Data Presentation
- **ListView and GridView:** Artworks are presented in a ListView on the Home page, My Arts page, and Favorite page. A search functionality is provided to filter artworks based on keywords.
- **Search Functionality:** Implemented on the Home page to quickly find specific artworks.

### State Management
- **State Management with GetX:** App state is managed using the GetX package, ensuring responsive and dynamic UI updates.

### Navigation and Routing
- **BottomNavigationBar:** The app features a Bottom Navigation Bar with options like Home, Favorite, Add Artwork, My Artwork, and Profile.
- **Navigation between Screens:** Smooth navigation is implemented between different pages, including Home, My Artwork, and Profile.

### Dialogs and Alerts
- **Confirmation Dialogs:** Displayed when users attempt to delete an artwork or logout their account, ensuring they confirm the action.

### UI Design
- **Modern and Intuitive Design:** The app uses consistent theming, modern layouts, and appropriate color schemes to enhance user experience.
- **Custom Fonts:** Google Fonts is used to provide a distinct and appealing text style across the app.

### Error Handling and Loading Indicators
- **Loading Indicators:** Displayed while fetching data from Firebase, ensuring users are aware of ongoing processes.
- **Error Handling:** Errors are handled gracefully with appropriate user feedback to maintain a smooth experience.

### Final Touches
- **Thorough Testing:** The app has been tested to ensure all functionalities work as expected.
- **Performance Optimization:** The app has been optimized for performance, ensuring a smooth user experience.

## Setup Guide

### Clone the Repository
1. Clone the repository from GitHub: [Your GitHub Repository Link]

### Install Dependencies
```bash
flutter pub get
```

## Firebase Configuration

1. Add your Firebase configuration files to the respective directories:
   - `google-services.json` for Android

## Run the App

```bash
flutter run
```

## Using the App

1. **Sign-Up/Login:** Create an account or log in using your credentials.
2. **Add Artwork:** Navigate to the Add Artwork page using the '+' button in the Bottom Navigation Bar.
3. **View Artworks:** Explore the Home page to view all artworks. Use the search bar to filter artworks by title or artist name.
4. **Manage Your Artworks:** Access the My Artwork page to edit or delete your artworks.

## Demo

- **Video Demo:** [Video Demo Link](https://drive.google.com/drive/folders/1mb9PljibNCipRgS3iKeR2RX1YIb_lYOM?usp=sharing)
- **Live Demo:** [Live Demo Link](https://drive.google.com/drive/folders/1mb9PljibNCipRgS3iKeR2RX1YIb_lYOM?usp=sharing)

## Conclusion

ArtHive provides a comprehensive platform for artists to manage and showcase their artwork collections. By integrating essential Flutter development principles with Firebase's powerful backend, this app ensures a seamless and enriched user experience.
