# NYTimes Demo

## Overview
NYTimes Demo is a Swift project that showcases the use of the Most Popular Articles API provided by The New York Times. It is built using SwiftUI, with a focus on clean architecture and efficient performance.

## Features
- Displays the most popular articles fetched from the NYTimes API.
- Utilizes SwiftUI for building user interfaces.
- Implements a ViewModel to manage state and logic.
- Includes a simple networking layer with custom error handling.
- Caches images locally to improve load times and reduce API calls.

## Requirements
- **Xcode**: Version 16.1 or higher.
- **macOS**: Version 12.0 or higher.
- **Swift**: Version 5.7 or higher.

## Getting Started
1. Clone the repository:
   ```bash
   git clone [<repository-url>](https://github.com/DroidFxGit/NYTimes_Demo.git)
   ```
2. Open the project file:
   ```
   NYTimes_Demo.xcodeproj
   ```
3. In Xcode, select the desired simulator or device.
4. Click `Run` to build and launch the project. The app should compile and run without issues.

## Architecture
- **SwiftUI**: Used for building a declarative UI.
- **ViewModel**: Follows the MVVM pattern to handle state and business logic.
- **Networking Layer**:
  - Handles API requests and responses.
  - Implements custom error handling to provide clear feedback.
- **Image Caching**:
  - Stores downloaded images locally.
  - Reduces repeated API calls for images, improving performance.

## API Details
### Most Popular Articles API
- **API Name**: Most Popular Articles API
- **API Key**: `qTl6HA9lEk9bHwEMNSrdjRAceMnSqQEZ`
  - In case the key expires, request a new one from The New York Times Developer portal.
- **Documentation**: [Most Popular Articles API Overview](https://developer.nytimes.com/docs/most-popular-product/1/overview)

## Contributing
Contributions are welcome! Please fork the repository and submit a pull request with your changes.

## License
This project is licensed under the MIT License. See the `LICENSE` file for details.

---
For further assistance, please contact the repository maintainer or open an issue.


