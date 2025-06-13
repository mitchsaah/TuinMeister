# 🌱 TuinMeister – Slim Tuinbeheer met AI en Sensoren

**TuinMeister** is een slimme, gebruiksvriendelijke en betaalbare oplossing die tuinliefhebbers helpt bij het efficiënt verzorgen van hun planten – zowel binnen als buiten. Door het combineren van sensortechnologie, AI en een intuïtieve SwiftUI-app kunnen gebruikers in realtime inzicht krijgen in de toestand van hun planten én gepersonaliseerd advies ontvangen.

---


## Features

### Hardware
1. Sluit je sensors aan op de ESP32-S3:
   - Soil Moisture
   - Humidity
   - UV
2. Upload de Arduino firmware (`.ino` file) met BLE + Wi-Fi provisioning naar je board.
3. Zorg dat Firebase URL en Wi-Fi credentials correct ingesteld zijn in de code.

### Mobile App (SwiftUI)
- **Firebase Auth** voor veilige login
- **Firebase Realtime Database & Firestore** voor opslag van plant- en sensordata
- **BLE-device setup flow**: detectie → Wi-Fi provisioning → configuratie (Instellen van Wi-Fi)
- **OpenWeather API-integratie** voor actuele weerberichten
- **Plant.id API** integratie voor plantherkenning met AI
- **Notificatiesysteem** met watergeefadvies en alerts
- **Dashboard** met live sensorwaarden, weerdata, AI scanner met Groen Archief en artikels van in Vlaanderen
- **Plantendetailweergave** inclusief onderhoudsniveau, herkomst en type

---

## Onderzoeksvraag

**"Hoe kan een betaalbaar en gebruiksvriendelijk systeem met geïntegreerde AI-functionaliteit tuinliefhebbers ondersteunen bij het efficiënt beheren en verzorgen van hun tuin en planten?"**

Deze vraag werd beantwoord met de ontwikkeling van **TuinMeister** – een concrete implementatie die technologie toegankelijk maakt voor de Vlaamse tuinliefhebber.

---

## Setup

### Hardware
1. Sluit je sensors aan op de ESP32-S3:
   - Soil Moisture → GPIO 4
   - Humidity → GPIO 5
   - UV → GPIO 15
2. Upload de Arduino firmware (`.ino` file) met BLE + Wi-Fi provisioning naar je board.
3. Zorg dat Firebase URL en Wi-Fi credentials correct ingesteld zijn in de code.

### App
1. Clone de repo
2. Installeer afhankelijkheden via Xcode (Firebase SDK, Alamofire, etc.)
3. Voeg `GoogleService-Info.plist` toe aan het project
4. Voeg je eigen `Secrets.plist` toe met de API keys


## Toekomstmogelijkheden
- Integratie met HomeKit of Google Home
- Waterpomp aansturing via relais
- Machine learning model voor zelflerend irrigatieschema
- Community met plantenervaringen en tips
- Uitgebreidere tips en notificaties


## Bronnen
- https://developer.apple.com/documentation/swiftui/applying-custom-fonts-to-text/
- https://developer.apple.com/documentation/xcode/configuring-your-app-icon
- https://www.appicon.co/
- https://github.com/invertase/react-native-firebase/issues/7338 
- https://randomnerdtutorials.com/esp32-wi-fi-manager-asyncwebserver/
- https://www.electronicshub.org/esp32-bluetooth-tutorial/
- https://en.m.wikipedia.org/wiki/List_of_Wi-Fi_microcontrollers
- https://openweathermap.org/api
- https://newsdata.io/search-news
- https://developer.apple.com/documentation/swiftui/datepicker
- https://developer.apple.com/tutorials/app-dev-training/creating-a-navigation-hierarchy
- https://medium.com/better-programming/flow-navigation-with-swiftui-4-e006882c5efa
- https://developer.apple.com/documentation/swiftui/animation
- https://www.vtwonen.be/tuinieren/dit-zijn-de-10-populairste-tuinplanten~3abeda5?referrer=https%3A%2F%2Fwww.google.com%2F
- https://developer.apple.com/documentation/swiftui/progressview
