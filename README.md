**Assignment: Data Fetching and Displaying**
========================================

**Overview:**
-------------

This Flutter application fetches data from an API endpoint (`https://jsonplaceholder.typicode.com/posts`) and displays a list of posts. The app includes various features such as search functionality, pull-to-refresh, theming with dark mode support, smooth animations, and a post detail page.

How to Run the Project:
-----------------------

1.  Clone the repository.

2.  Ensure `Flutter SDK` is installed.

3.  Run `flutter pub get` to install dependencies.

4.  Start the application using `flutter run`.


**Dependencies Used:**
----------------------

1.  `flutter/material.dart` (For UI components)

2.  `http` (For making API requests)

3.  `dart:convert` (For parsing JSON responses)

Features:
---------

1.  **Fetch Posts**: Retrieves posts from a remote API using the `http` package.

2.  **Search Functionality**: Allows users to search for post by title.

3.  **Pull to Refresh**: Enables users to refresh the list by pulling down.

4.  **Dark Mode Support**: Implements a theming system with both light and dark modes.

5.  **Post Detail Page**: Users can tap on a post to view detailed content.

6.  **Animated List and Transitions**: Smooth animation when displaying, adding or removing posts.

7.  **Error handling & Retry Mechanism**: Displays an error message and a retry button in case of network failure.


**Approach:**
-------------

1.  **State Management**: Uses a `StatefulWidget` to manage API data, loading states, search filters and errors.

2.  **API Request**: Utilizes the `http.get` method to fetch posts from the API.

3.  Data Parshing: Decodes JSON response into a list of posts.

4.  **Search Implementation**:

    1.  Uses a `TextField` to capture user input.

    2.  Filters posts dynamically based on the search query.

5.  **Pull-to-Refresh**: Uses `RefreshIndicator` to allow users to refresh the post list manually.

6.  **Theming & Dark Mode**: Implements `ThemeData` to provide light and dark themes.

7.  **Post Detail Page**:

    1.  Navigates to a detailed post screen when a post is tapped.

    2.  Displays post title and full body with enhanced UI.


**Challenges Faced:**
---------------------

1.  **Efficient Search Implementaion**: Ensuing a fast and responsive search experience.

2.  **Maintaining State in Dark Mode**: Persisting user-selected themes across app restarts.

3.  **Ensuring Smooth UI Transitions**: Implementating animations without performance overhead.

4.  **Handling API Errors**: Managing different failure scenarios like no internet connection and incorrect API responses.


