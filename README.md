# 🛒 Flutter eCommerce App

A modern eCommerce mobile application built using Flutter, implementing **Clean Architecture**, **BLoC (Business Logic Component)** for state management, and integrating features such as user authentication, product browsing, cart management, and order checkout.

---

## 📱 Features

- 🧑‍💼 **Authentication**
  - Sign Up / Sign In with validation
  - Error handling for common cases

- 🛍️ **Product Listing**
  - Browse paginated products
  - Filter by category or keyword

- 🛒 **Cart Management**
  - Add/remove items to/from the cart
  - View cart contents and total cost

- 🚚 **Order Checkout**
  - Enter delivery information
  - Place order

- 👤 **User Profile**
  - View/edit user details
  - Logout

- 🧭 **Navigation**
  - Bottom navigation bar (Snake style)
  - Separate views for Home, Categories, Cart, and Other/Profile

---

## 📂 Project Structure (Clean Architecture)
<details>
  <summary>lib/</summary>
  <ul>
    <li>
      <details>
        <summary><code>core/</code> - Constants, error handling, utilities</summary>
        <ul>
          <li><code>constants/</code></li>
          <li><code>error/</code></li>
          <li><code>utils/</code></li>
        </ul>
      </details>
    </li>
    <li>
      <details>
        <summary><code>data/</code> - Data sources, models, repositories</summary>
        <ul>
          <li><code>models/</code></li>
          <li><code>datasources/</code></li>
          <li><code>repositories/</code></li>
        </ul>
      </details>
    </li>
    <li>
      <details>
        <summary><code>domain/</code> - Entities and use cases</summary>
        <ul>
          <li><code>entities/</code></li>
          <li><code>usecases/</code></li>
          <li><code>repositories/</code> (abstract definitions)</li>
        </ul>
      </details>
    </li>
    <li>
      <details>
        <summary><code>presentation/</code> - Views, widgets, BLoC/Cubit</summary>
        <ul>
          <li><code>views/</code></li>
          <li><code>widgets/</code></li>
          <li><code>blocs/</code></li>
        </ul>
      </details>
    </li>
    <li><code>main.dart</code> - Entry point</li>
  </ul>
</details>

---

## 🧰 Tech Stack

- **Flutter**
- **Dart**
- **BLoC / Cubit**
- **Equatable**
- **Flutter EasyLoading**
- **HTTP Client**
- **SnakeNavigationBar**
- **Sizer** for responsive UI

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (≥3.x)
- Android Studio / VSCode
- Android Emulator or physical device

### Installation

```bash
git clone https://github.com/your-username/flutter_ecommerce_app.git
cd flutter_ecommerce_app
flutter pub get
```

## 🏗️ Build Instructions
📦 Build APK
``` bash
flutter build apk --release
```
Output:
build/app/outputs/flutter-apk/app-release.apk

## 🧪 Run in Emulator
``` bash
flutter run
```

## 🔐 Environment Setup
Update baseUrl in lib/core/constants/strings.dart with your API URL.
Configure headers/auth in the data sources if needed.

## 🧪 Testing
You can write unit and widget tests inside the test/ directory.

To run tests:
``` bash
flutter test
```

## 🤝 Contribution Guide
- Fork the project
- Create your feature branch: git checkout -b feature/AmazingFeature
- Commit your changes
- Push to the branch
- Open a Pull Request

## 📃 License
This project is licensed under the MIT License.

“Code today. Innovate tomorrow.”
Let me know if you'd like it exported as a downloadable file or tailored for GitHub Pages.
