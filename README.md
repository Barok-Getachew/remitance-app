
# 💸 Remitance App

A modern, secure mobile application for sending and receiving money with biometric authentication support. Built using Flutter, this app enables users to top-up, transfer money, and manage transactions seamlessly.

---

## ✨ Features

- 🔐 Biometric Authentication (Fingerprint/Face ID)
- 💰 Send & Receive Money
- 📜 Transaction History
- 🌙 Light/Dark Theme Toggle
- ⚙️ Hive-based Local Storage

---

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/remitance.git
cd remitance
```

### 2. Install Dependencies

Make sure you have Flutter installed. Then run:

```bash
flutter pub get
```

### 3. Run the App

```bash
flutter run
```

> You can run the app on an emulator or physical device.

---

## 🔧 Configuration

### Biometric Authentication

Ensure your test device supports biometrics. Biometric login is automatically prompted if the user has it enabled in settings.

### Hive Boxes

The app uses `Hive` for local data storage. Settings like `themeMode` and `biometricKey` are stored locally using Hive.

---

## 📂 Project Structure

```bash
lib/
├── app/                    # Global app configuration and controllers
├── core/                   # Enums, constants, utilities
├── modules/
│   ├── auth/               # Authentication-related logic
│   └── transaction/        # Transaction-related logic and UI
├── widgets/                # Shared UI widgets
└── main.dart               # App entry point
```

---

## 📱 Screenshots

> *(Add your app screenshots here to showcase the UI)*

---

## 🧪 Testing

To run all tests:

```bash
flutter test
```

---

## 📃 License

This project is licensed under the MIT License.

---

## 🙋‍♂️ Author

Developed by **Biruk Getachew**  
📧 [your.email@example.com]  
🌐 [LinkedIn](https://www.linkedin.com/in/your-profile) | [GitHub](https://github.com/your-username)
