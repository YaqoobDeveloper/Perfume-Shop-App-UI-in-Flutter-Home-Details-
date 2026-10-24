# Perfume Shop App UI in Flutter (Home & Details) 🌸

A soft **purple and white perfume shop** built with Flutter, with two screens: a **Home** screen with search, category chips, a promo banner, a product grid and featured perfumes, and a **Details** screen where you pick a colour edition, bottle size and quantity before buying. The perfume bottles are drawn in code with `CustomPaint`, so the app uses no images. Text is in the clean Poppins font.

The UI is split into small, reusable components, the same way you would structure a React Native app.

## 📱 Screenshots

### Home Screen

<img width="858" height="900" alt="Perfume Shop Home Screen" src="https://github.com/user-attachments/assets/b451e93a-530b-4acb-a4d6-c3b16f10e9ca" />

### Details Screen

<img width="862" height="900" alt="Perfume Shop Details Screen" src="https://github.com/user-attachments/assets/522e4957-caaf-4b5a-afb3-b2b2edbaf8ce" />

## 🚀 Demo & Project

🎬 **YouTube Short:**  
https://youtube.com/shorts/sQWbFj4bWDo?si=B8OufHLEad9uegkx

🌐 **Live Preview:**  
https://yaqoobdeveloper.github.io/Perfume-Shop-App-UI-in-Flutter-Home-Details-/

💻 **GitHub Repository:**  
https://github.com/YaqoobDeveloper/Perfume-Shop-App-UI-in-Flutter-Home-Details-

## ✨ Features

- 💜 Soft purple and white theme, solid colours only
- 🔍 Live search by perfume name
- 🏷️ Category chips: Women's, Men's, Kids and Unisex
- 🎁 Promo banner with a **Shop Now** button
- 🧴 Perfume bottles drawn in code in three shapes: classic, tapered and square
- ⭐ Product grid with prices and a featured list with ratings
- 🎨 Details screen with colour editions that recolour the bottle
- 📏 50 / 100 / 150 ml sizes with live price update
- ➕ Quantity stepper and **Buy Product** button that updates the cart badge
- ❤️ Favourite button on every perfume, kept while you browse
- 🧭 Custom bottom bar with a floating scan button
- 🧩 Reusable components with a barrel export (like `components/index.ts`)

## 📁 Project Structure

```text
lib/
├── main.dart
├── app.dart
├── screens/
│   ├── home_screen.dart
│   └── product_details_screen.dart
├── components/aroma/
│   ├── aroma_components.dart   # barrel export
│   ├── perfume_bottle.dart
│   ├── product_card.dart
│   ├── featured_tile.dart
│   ├── promo_banner.dart
│   ├── category_chips.dart
│   ├── search_bar.dart
│   ├── pill_button.dart
│   ├── square_icon_button.dart
│   ├── cart_icon.dart
│   └── aroma_bottom_bar.dart
├── data/
│   ├── products.dart
│   └── shop.dart
└── theme/aroma_colors.dart
```

## 🛠️ Built With

- **Flutter 3.47.2**
- **Dart**
- [google_fonts](https://pub.dev/packages/google_fonts) (Poppins)

## 📋 Requirements

- Flutter **3.47.2** or compatible version
- Dart SDK included with Flutter
- Android Studio or VS Code
- Xcode for iOS development

## ▶️ Run

### 1. Clone the repository

```bash
git clone https://github.com/YaqoobDeveloper/Perfume-Shop-App-UI-in-Flutter-Home-Details-.git
```

### 2. Navigate to the project

```bash
cd Perfume-Shop-App-UI-in-Flutter-Home-Details-
```

### 3. Install dependencies

```bash
flutter pub get
```

### 4. Run the app

```bash
flutter run
```

## 👨‍💻 Created By

### Yaqoob Developer

**Flutter Developer & YouTuber**

▶️ **YouTube:**  
https://youtube.com/@yaqoob_developer

🌐 **Website:**  
https://yaqoobdeveloper.com/

⭐ If you find this project useful, consider giving the repository a **star**!
