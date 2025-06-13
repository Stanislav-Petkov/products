# Products App

A Flutter mobile application that displays a list of products in a grid layout, featuring infinite scroll, product detail navigation, add/remove functionality, and favorite toggling. The app uses the BLoC pattern with in-memory state management for a responsive and maintainable architecture.

## Features

### 1. Product Grid View
- Displays products in a 2-column grid.
- Each grid item shows:
  - Product title
  - Description snippet
  - Favorite toggle (heart icon)

### 2. Infinite Scrolling
- Dynamically loads more products as the user scrolls, providing a seamless browsing experience.

### 3. Add Product
- Accessible via a three-dot menu (AppBar action) on the main screen.
- Opens a form/dialog to input product title and description.
- Adds the new product to the in-memory list and refreshes the UI instantly.

### 4. Remove Product
- Remove a product via long press or swipe gesture.

### 5. Favorite Toggle
- Tap the heart icon to mark/unmark a product as a favorite.
- Favorite status updates in real time, both in the grid and on the details page.

### 6. Product Details Page
- Tap a product to navigate to its detail screen.
- Displays full product title, description, and favorite status.
- Allows toggling favorite from this screen.
- Changes reflect immediately when navigating back.

## Architecture

- **State Management:** BLoC pattern (using `flutter_bloc`)
- **State Equality:** Uses `Equatable` to prevent unnecessary UI rebuilds and ensure efficient state comparison.
- **In-Memory Data:** All product data and state are managed in-memory; no backend or persistent storage.

## Behavior Expectations

- Efficiently appends new products as users scroll.
- UI updates reactively through state changes.
- UI rebuilds are minimized using `Equatable` for state comparison.
- Navigation between screens reflects real-time state changes.

## Testing

- Unit tests for BLoC logic:
  - Adding products
  - Removing products
  - Toggling favorite status

## Getting Started

### Installation

1. Clone the repository:
   ```sh
   git clone <repository-url>
   cd products
   ```

2. Get dependencies:
   ```sh
   flutter pub get
   ```

3. Run the app:
   ```sh
   flutter run
   ```

### Running Tests

```sh
flutter test
```

## License

[MIT](LICENSE)