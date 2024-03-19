# ManagerMobile

![Flutter](https://img.shields.io/badge/Flutter-2.0.5-blue.svg)
![Dart](https://img.shields.io/badge/Dart-2.12.3-green.svg)

ManagerMobile is a Flutter application designed for efficiently collecting and managing information about customer compressors on Android devices. It seamlessly synchronizes with a Windows Forms VB.net application, currently in production at the company I work for.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
- [Testing](#testing)
- [Contributing](#contributing)
- [License](#license)

## Overview

ManagerMobile leverages the power of Flutter to provide a modern and user-friendly interface for collecting compressor information. It is intended to enhance the data collection process, ensuring accuracy and efficiency.

## Features

- **Real-time Synchronization:** Keep your data up-to-date by seamlessly syncing with the Windows Forms VB.net application.
- **Intuitive UI/UX:** User-friendly design for a smooth and efficient data entry experience.
- **Offline Mode:** Continue working seamlessly without an internet connection, with data syncing when connectivity is restored.

## Getting Started

### Prerequisites

Before you begin, ensure you have Flutter and Dart installed on your development machine.

```bash
# Check Flutter version
flutter --version

# Check Dart version
dart --version
```

### Installation

1. Clone the Repository:
```bash
git clone https://github.com/leandrogaldino/ManagerMobile.git
```
2. Navigate to the Project Directory:
```bash
cd ManagerMobile
```
3. Get Dependencies:
```bash
flutter pub get
```
4. Run the Application:
```bash
flutter run
```
## Usage

1. Open the ManagerMobile application on your device.
2. Log in with your credentials.
3. Navigate through the intuitive interface to efficiently collect and manage compressor information.
4. Ensure regular synchronization to keep data updated with the Windows Forms VB.net application.

## Testing

This project uses the ObjectBox package, for unit testing do these steps:

1. Open GitBash
2. Enter the following command:
```bash
bash <(curl -s https://raw.githubusercontent.com/objectbox/objectbox-dart/main/install.sh)
```
3. Copy the downloaded lib/objectbox.dll to C:\Windows\System32\ (requires admin privileges).
4. Set openStore directory as 'test/' or any desired directory.
5. Database files will be generated within this specified directory.

## Contributing

You can contribute to the project in the following ways:

1. **Reporting Issues:**
   - Check if the issue is already reported [here](https://github.com/leandrogaldino/ManagerMobile/issues).
   - If not, open a new issue with a clear description and steps to reproduce.

2. **Requesting Features:**
   - Check if the feature is already discussed [here](https://github.com/leandrogaldino/ManagerMobile/issues).
   - If not, open a new feature request and describe what you'd like to see.

3. **Improving Documentation:**
   - Fork the repository.
   - Make your changes.
   - Submit a pull request.

4. **Writing Code:**
   - Fork the repository.
   - Create a new branch for your changes.
   - Make your changes.
   - Test thoroughly.
   - Submit a pull request.

5. **Reviewing Pull Requests:**
   - Check the [Pull Requests](https://github.com/leandrogaldino/ManagerMobile/pulls).
   - Test changes locally.
   - Provide constructive feedback.

6. **Providing Feedback:**
   - Comment on existing issues and pull requests.
   - Join discussions.

## License

This project is licensed under the MIT License.