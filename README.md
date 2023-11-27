# Video Call App using Flutter WebRTC

This project demonstrates a video calling application using Flutter WebRTC, enabling users to connect and communicate through video calls.

## Prerequisites

Flutter installed on your system.

## Structure

## Main File (main.dart)

### The main.dart file initializes the application and sets up the video call environment.

- HomeScreen: Initializes the Flutter application, sets up the signaling service, and navigates to the JoinScreen.

## Join Screen (join_screen.dart)

### The join_screen.dart file presents the user interface for joining a video call and handling incoming call requests.

### JoinScreen Class: Manages the UI for entering a callee's ID to initiate a call and handles incoming call requests.

## Call Screen (call_screen.dart)

The call_screen.dart file manages the video call interface and interaction between peers during a call.

CallScreen Class: Controls the video call interface, camera, microphone toggles, and peer connection setup.

## Services

### Signalling Service (signalling.service.dart)

- The signalling.service.dart file handles the communication with the signaling server for call establishment and handling.

#### SignallingService Class: Manages WebSocket connections, emits signaling events, and listens for incoming call requests.

## Usage

- Clone the repository.
- Open the project in your preferred Flutter IDE.
  Run the application on a supported device or simulator.

## Important Notes

- Ensure the correct setup and configuration of your signaling server URL in the code.
- Adjust permissions and access for the camera and microphone on your device to enable video calling functionality.

# To Use this Application

## Clone Repository

Clone the repository to your local environment.

```sh
git clone https://github.com/pradyumantomar/signalling-server.git
```

### Server Setup

#### Step 1: Go to webrtc-signalling-server folder

```js

cd webrtc-signalling-server

```

#### Step 2: Install Dependency

```js

npm install
```

#### Step 3: Run the project

```js

npm run start
```

---

### Client Setup

#### Step 1: Go to flutter_webrtc_app folder

```dart

cd flutter_webrtc_app
```

### Step 2: Get dependencies

```dart
flutter pub get
```

### Step 3: Update Signalling Server URL

in main.dart file, update the websocket url.

```dart
// signalling server url
final String websocketUrl = "SIGNALLING_SERVER_URL";
```

### Step 4: Run the sample app

Bingo, it's time to push the launch button.

```dart
flutter run
```
