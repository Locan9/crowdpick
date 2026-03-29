# 🗳️ Simple Vote App

A lightweight, voting application built with **Flutter**. 

---

## 🚀 How It Works

The app operates as a two-stage **State Machine**:

1.  **Setup Phase**: The coordinator defines the total number of voters and adds choice names. Data is stored in two synchronized lists (`names` and `votes`).
2.  **Voting Phase**: The UI "locks" the configuration. Users tap choices to increment counts until the voter limit is reached.
3.  **Result Phase**: Once the limit is hit, voting is disabled, and a "Restart" option appears to clear the state.

---

## 🛠️ Features

* **Input Validation**: Prevents adding empty strings or invalid voter counts.
* **One-Time Setup**: Ensures the total voter count remains constant once the poll begins.
* **Real-Time Progress**: Tracks `peopleVoted` vs `totalPeople` using Flutter's `setState`.


---

## 💻 Tech Stack

* **Language**: Dart (Flutter Framework).
* **Concepts Used**: State Management, Conditional Rendering, and List Indexing.
* **Logic Origin**: This app's logic is based on a simplified Python voting script.

---

## 🏃 Running the Project

1.  Open the folder in **VS Code**.
2.  Ensure your terminal is in the project directory (use `cd uitask` if needed).
3.  Connect a device or emulator.
4.  Run:
    ```bash
    flutter run
    ```


