# 📰 P_Paper – News App with API Integration

A dynamic News app built with Flutter and Dio, featuring Google & Email authentication, bookmarks, search functionality, and modern feature-based architecture.  
Check a demo on YouTube: *(add link here if available)*

---

## 🚀 Features

- Fetches news articles from REST APIs using Dio with efficient state management using Riverpod.
- Google & Email Sign-In for secure authentication.
- Bookmark articles for later reading.
- Search functionality to quickly find news articles.
- Supports light and dark mode with dynamic theming.
- Smooth navigation using go_router with Stateful Shell Routes.
- Optimized image caching for fast loading and smooth scrolling.
- Clean and responsive UI displaying article images, titles, and descriptions.

---

## 🗂 Folder Structure

```text
lib/
├── core/                 
│   ├── cache/
│   ├── constant/
│   ├── error/
│   ├── network/
│   ├── routing/
│   └── utils/
├── features/
│   ├── auth/
│   │   ├── data/
│   │   ├── domain/
│   │   │   └── repository/
│   │   └── presentation/
│   │       ├── provider/
│   │       └── widgets/
│   ├── bookmark/
│   │   └── presentation/
│   ├── comment/
│   ├── home/
│   ├── news/
│   │   ├── data/
│   │   ├── domain/
│   │   │   └── repository/
│   │   ├── presentation/
│   │   │   └── provider/
│   │   ├── service/
│   │   └── widgets/
│   ├── onboarding/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │       ├── provider/
│   │       └── widgets/
│   ├── profile/
│   │   ├── presentation/
│   │   └── widget/
│   └── splash/
│       ├── data/
│       └── presentation/
│           └── provider/
└── shared/
    └── widget/
```

---

🏗 Architecture
- **Feature-based structure for better scalability and maintainability.**

- **Domain layer: Handles repositories, entities, and business logic.**

- **Data layer: Handles API integration, caching, and network calls.**

- **Presentation layer: Flutter UI widgets and Riverpod providers.**

- **State management using Riverpod's StreamProvider for real-time updates.**
- **Routing: go_router with Stateful Shell Routes.**
- **Caching: Efficient image caching for smooth UX.**
- **Theming: Dynamic dark and light mode support.**

---
**⚡ Getting Started**

**Prerequisites**

Flutter SDK

News API key (not for now)

Firebase project for authentication

Google services configuration for Google Sign-In

1. Installation

Clone the repository : git clone (repo url)

cd p-paper

2. Install dependencies : flutter pub get

3. Run the app : flutter run

---
**🔐 Authentication**

**Google Sign-In**

**Email & Password Sign-In**

---

**📈 Future Improvements**

- **More professional UI/UX design**

- **Enhanced error handling and validation**

- **Task categorization and folder system**

- **Push notifications for tasks**

- **Offline support**

---
