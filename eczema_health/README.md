# 🌿 Eczema Health

## 🩺 Overview
**Eczema Health** is a cross-platform mobile app built with Flutter that empowers individuals with eczema to manage and monitor their condition. Through symptom logs, lifestyle tracking, medication management, and a visual dashboard, users gain personalized insights to improve their care routines.

## ✨ Features
- 📝 **Symptom Logging** – Track flare-ups by date, severity, and body location
- 📸 **Photo Tracking** – Capture and view chronological images of affected areas
- 🍽️ **Lifestyle Factors** – Log diet, hydration, sleep, and stress to monitor triggers
- 💊 **Medication Management** – Add/edit medications, record dosage, set reminders
- 📊 **Analytics Dashboard** – Visualize trends and correlation between symptoms and lifestyle
- 🔐 **User Authentication** – Secure login and sign-up using Supabase

## 🛠 Installation

### ⚙️ Requirements
- Flutter SDK ≥ 2.0
- Dart ≥ 2.12
- Android Studio / VS Code
- Supabase project with credentials

### 🚀 Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/eczema-health.git
   cd eczema-health
   ```

2. Install packages:
   ```bash
   flutter pub get
   ```

3. Add Supabase credentials:
   Create `lib/config/supabase_secrets.dart`:
   ```dart
   class SupabaseSecrets {
     static const String supabaseUrl = 'YOUR_SUPABASE_URL';
     static const String supabaseKey = 'YOUR_SUPABASE_KEY';
   }
   ```

4. Launch the app:
   ```bash
   flutter run
   ```

## 📲 Usage
1. 🔐 **Sign In** – Create an account or log in
2. 📝 **Log Symptoms** – Enter symptom details and severity
3. 📷 **Upload Photos** – Track eczema visually over time
4. ⏰ **Set Medication Reminders** – Stay on top of treatment routines
5. 💡 **Track Lifestyle** – Log hydration, sleep, diet, and stress
6. 📈 **Explore Dashboard** – Review trends and correlations

## 🧱 Project Structure
```
lib/
├── config/               # Secrets and environment settings
├── core/                 # Constants, themes, UI components
├── data/                 # Local DB (Drift), cloud sync (Supabase)
├── features/             # Screens, widgets by domain (auth, symptoms, photos, etc.)
├── navigation/           # Routing setup
└── utils/                # Helpers and validators
```

## 🚧 Future Goals
- 🧠 **AI-Powered Flare Predictions** – Use ML to analyze patterns and predict potential flare-ups
- 🗂️ **Data Export** – Allow users to export logs as PDF for clinical use
- 🌙 **Dark Mode** – Improve usability for night-time logging
- 🔄 **Cloud Sync Improvements** – Real-time sync across devices
- 🛡️ **Enhanced Privacy** – End-to-end encryption and consent settings
- 🔔 **Smarter Notifications** – Adaptive reminders based on usage history
- 📊 **Deeper Insights** – Graphs showing correlation between lifestyle and symptoms
- 🧪 **A/B Testing Engine** – Personal treatment experiments and journaling

## 🧰 Tech Stack
- **Flutter & Dart**
- **Drift** (local database)
- **Supabase** (authentication & backend)
- **TableCalendar**, **Image Picker**, and other Flutter packages


