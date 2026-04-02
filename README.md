# 🗳️ CrowdPick – Group Voting App

A lightweight, group voting application built with **Flutter**.

---

## 🎯 Problem It Solves

Group decisions can be uncomfortable when people feel **pressured by others’ opinions**. In many situations, individuals may change their vote just to match the group, avoid conflict, or not stand out.

This app solves that by making voting **simple and pressure-free**. Each user can vote independently without influence from others, allowing results to better reflect what people actually prefer rather than what the group expects.

The goal is to encourage **fair, unbiased decisions** in small group settings.

---

## 🚀 How It Works

The app operates as a two-stage **State Machine**:

1. **Setup Phase**: The coordinator defines the total number of voters and adds choice names. Data is stored in two synchronized lists (`names` and `votes`).
2. **Voting Phase**: The UI "locks" the configuration. Users tap choices to increment counts until the voter limit is reached.
3. **Result Phase**: Once the limit is hit, voting is disabled, and a "Restart" option appears to clear the state.

---

## 🧠 Logic Breakdown

The application is built around a simple state-driven workflow:

* The app starts in **setup mode**, where user inputs are collected.
* Once voting begins, the state changes and input is locked.
* Each vote updates the corresponding index in the `votes` list using the same position as `names`.
* When `peopleVoted` reaches `totalPeople`, the app transitions to the **result state** and disables further interaction.

This ensures consistent data flow and prevents invalid operations during runtime.

---

## 🛠️ Features

* **Input Validation**: Prevents adding empty strings or invalid voter counts.
* **One-Time Setup**: Ensures the total voter count remains constant once the poll begins.
* **Real-Time Progress**: Tracks `peopleVoted` vs `totalPeople` using Flutter's `setState`.

---

## 💻 Tech Stack

* **Language**: Dart (Flutter Framework)
* **Concepts Used**: State Management, Conditional Rendering, and List Indexing
* **Logic Origin**: Based on a simplified Python voting script

---

## 📁 File Structure

```id="6t2d5x"
crowdpick/
├── lib/
│   └── main.dart        # Main app logic (UI + voting state machine)
│
├── android/             # Android-specific configuration and build files
├── ios/                 # iOS-specific configuration and build files
│
├── test/
│   └── widget_test.dart # Basic Flutter test file
│
├── pubspec.yaml         # Project dependencies and configuration
├── pubspec.lock         # Locked dependency versions
├── README.md            # Project documentation
```

**Notes:**

* All core logic is inside `main.dart` (state handling, voting logic, UI updates)
* Platform folders (`android/`, `ios/`) are required for running on devices but rarely modified

---

## 🏃 Running the Project

1. Open the folder in **VS Code**
2. Ensure your terminal is in the project directory:

   ```bash
   cd uitask
   ```
3. Connect a device or emulator
4. Run:

   ```bash
   flutter run
   ```
