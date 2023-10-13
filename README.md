# LBG Virtusa-iOS Tech Test

#### Task :
The application fetches a list of currencies from the API endpoint where I can get the live data of currencies of different countries. It helps in converting the currencies according to the provided input. We will be able to modify the base currency by selecting the currency name in the picker.

Launch the application and the screen will be presented with a list of currencies, names, values and their symbols. In order to reflect the change in the amount entered, enter in the text field and use the Picker to modify the base currency.

#### Key takeaways :

- This app is developed with the latest Xcode 15 and dependency target - iOS 16 to support latest currency symbols and also async await feature. Developed using SwiftUI to render the data in the User Interface.
- Built using MVVM Architecture and Unit test cases for testability, scalability and maintainability
- Used Async await to fetch data from API endpoint

#### Key Features :

- Currency conversion between multiple currencies
- Select any currency as Base currency and check results
- Real-time exchange rate data retrieval
- User-friendly interface with SwiftUI
- Clean and maintainable code architecture using MVVM
- Unit testing with XCTestCase for code reliability

#### Technologies Used :

- SwiftUI
- MVVM (Model-View-ViewModel) architecture
- Async - Await for API requests
- XCTest for unit testing

#### Unit Tests: 

In Xcode, go to the "Product" menu and choose "Test" or use the shortcut (Cmd+U).
View the test results in the Xcode test navigator.
