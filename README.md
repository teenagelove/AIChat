<p align="right"><b>English</b> | <a href="./README_RU.md">Русский</a></p>

# <img src="AIChat/Resources/Assets.xcassets/AppIcon.appiconset/screen.png" width="40" height="40" alt="AIChat Logo"> AIChat

<p align="left">
  <img src="https://img.shields.io/badge/iOS-16%2B-000000?logo=apple&logoColor=white" alt="iOS 16+"/>
  <img src="https://img.shields.io/badge/SwiftUI-0A84FF?logo=swift&logoColor=white" alt="SwiftUI"/>
  <img src="https://img.shields.io/badge/MVVM+C-Architecture-orange?logo=swift&logoColor=white" alt="MVVM+C Architecture"/>
  <img src="https://img.shields.io/badge/Structured_Concurrency-5856D6?logo=swift&logoColor=white" alt="Structured Concurrency"/>
  <img src="https://img.shields.io/badge/Apphud-SDK-FF6B6B?logo=apple&logoColor=white" alt="Apphud SDK"/>
  <img src="https://img.shields.io/badge/StoreKit-2-007AFF?logo=apple&logoColor=white" alt="StoreKit 2"/>
  <img src="https://img.shields.io/badge/Lottie-00DDB3?logo=lottiefiles&logoColor=white" alt="Lottie"/>
  <img src="https://img.shields.io/badge/PixVerse-API-9B59B6?logo=video&logoColor=white" alt="PixVerse API"/>
  <img src="https://img.shields.io/badge/Conventional_Commits-FE5196?logo=git&logoColor=white" alt="Conventional Commits"/>
</p>

An AI-powered chat application for iOS, built with **SwiftUI** and the **MVVM+C** (Model-View-ViewModel + Coordinator) architectural pattern. The application provides an intelligent chat interface powered by the Dola AI API, featuring video generation capabilities through the PixVerse API, subscription management via Apphud, and a modern dark-themed UI with gradient accents.

## ✨ Features

- **💬 AI Chat:** Intelligent conversation interface with the Dola AI assistant, featuring message history, copy functionality, and response regeneration.
- **🎬 Video Generation:** Transform photos into animated videos using PixVerse AI templates with customizable format, quality, and duration settings.
- **📁 Chat History:** Browse and manage previous conversations with a organized chat list grouped by date.
- **💎 Subscription Management:** In-app purchases powered by Apphud SDK with StoreKit 2 integration for weekly and yearly plans.
- **🎨 Modern UI:** Dark-themed interface with gradient accents, smooth Lottie animations, and responsive design.
- **🔄 Structured Concurrency:** Built with modern Swift concurrency using async/await and @MainActor for thread-safe operations.
- **🌍 Localization:** Full localization support with String Catalog (Localizable.xcstrings).
- **🛡️ Robust Error Handling:** Comprehensive error handling with user-friendly retry functionality and toast notifications.

## 🖼️ Preview

<div align="center">

| Paywall | Chat |
|:---:|:---:|
| <img src="AIChat/Resources/Assets/PayWall.gif" alt="Paywall" width="100%"/> | <img src="AIChat/Resources/Assets/Chat.gif" alt="Chat" width="100%"/> |

| Video | Error |
|:---:|:---:|
| <img src="AIChat/Resources/Assets/Video.gif" alt="Video" width="100%"/> | <img src="AIChat/Resources/Assets/Error.gif" alt="Error" width="100%"/> |

</div>

## 🛠️ Technologies & Architecture

The project is built using the **MVVM+C (Model-View-ViewModel + Coordinator)** architectural pattern to ensure separation of concerns, testability, and clean navigation.

### ⚙️ Core Technologies

- **SwiftUI:** For building a declarative and responsive user interface.
- **Structured Concurrency:** Using async/await, @MainActor, and Task for safe concurrent code.
- **Coordinator Pattern:** For managing navigation flow and decoupling views from navigation logic.
- **Protocol-based DI:** Services injected via protocols for testability and flexibility.

### 📦 Dependencies (SPM)

- **[Apphud SDK](https://github.com/apphud/ApphudSDK):** For subscription management and in-app purchases.
- **[Lottie](https://github.com/airbnb/lottie-spm):** For rendering high-quality vector animations.

### 🔌 APIs

- **Dola AI API:** Backend service for AI chat functionality with message history and persona support.
- **PixVerse API:** AI video generation service supporting template-based photo-to-video transformation.

### 📏 Code Standards

- **Conventional Commits:** All commits follow the [Conventional Commits](https://www.conventionalcommits.org/) specification.
- **Private Extensions:** All private functions and properties organized in private extensions.
- **Localization:** All user-facing strings use `String(localized:)` for localization support.
- **One Entity Per File:** Each model, view, and service in its own dedicated file.

## 📁 Project Structure

```text
AIChat/
├── App/
│   ├── AIChatApp.swift              # App entry point
│   └── Screen.swift                 # Navigation screen definitions
├── Helpers/
│   ├── Constants.swift              # App constants and API keys
│   ├── Date+GroupKey.swift          # Date grouping extensions
│   ├── Font+Ext.swift               # Custom font definitions
│   ├── LinearGradient+Ext.swift     # Gradient utilities
│   ├── SFSymbol.swift               # SF Symbol constants
│   ├── String+Ext.swift             # String parsing utilities
│   └── HTTPResponseValidator.swift  # Network response validation
├── Models/
│   ├── Chat/                        # Chat-related models
│   │   ├── ChatMessage.swift
│   │   ├── ChatSection.swift
│   │   ├── DolaChat.swift
│   │   ├── DolaChatMessage.swift
│   │   ├── DolaMessageResponse.swift
│   │   └── ToastState.swift
│   ├── Paywall/                     # Subscription models
│   │   ├── Benefit.swift
│   │   └── Plan.swift
│   ├── Video/                       # Video generation models
│   │   ├── PixverseGenerationResponse.swift
│   │   ├── PixverseGenerationStatusResponse.swift
│   │   ├── TemplatesResponse.swift
│   │   ├── VideoCategory.swift
│   │   ├── VideoFormat.swift
│   │   ├── VideoQuality.swift
│   │   └── VideoTemplate.swift
│   └── Mock/                        # Mock data for previews
├── Navigation/
│   └── Coordinator.swift            # Navigation coordinator
├── Services/
│   ├── Chat/                        # Dola AI chat service
│   │   ├── ChatService.swift
│   │   └── ChatServiceProtocol.swift
│   ├── Network/                     # Network layer
│   │   ├── HTTPMethod.swift
│   │   ├── NetworkRequest.swift
│   │   ├── NetworkRequest+Ext.swift
│   │   └── Requests/               # API request definitions
│   ├── Subscription/                # Apphud subscription service
│   │   ├── SubscriptionService.swift
│   │   └── SubscriptionServiceProtocol.swift
│   └── VideoGeneration/             # PixVerse video generation
│       ├── VideoGenerationService.swift
│       └── VideoGenerationServiceProtocol.swift
├── ViewModels/
│   ├── ChatViewModel.swift
│   ├── ChatListViewModel.swift
│   ├── PaywallViewModel.swift
│   ├── VideoGenerateViewModel.swift
│   └── VideoTemplatesViewModel.swift
├── Views/
│   ├── Chat/                        # Chat screen views
│   ├── ChatList/                    # Chat history views
│   ├── Main/                        # Main screen views
│   ├── Paywall/                     # Subscription paywall views
│   ├── Video/
│   │   ├── ResultVideoGen/          # Video generation result views
│   │   ├── TemplateSelection/       # Video template selection views
│   │   └── VideoGenerate/           # Video generation configuration views
│   └── Components/                  # Reusable UI components
│       ├── Buttons/                 # Button components
│       ├── Cards/                   # Card components
│       ├── Feedback/                # Toast and error views
│       ├── Input/                   # Input bar and dropdowns
│       ├── Loading/                 # Loading indicators
│       ├── Lottie/                  # Lottie animation views
│       └── Other/                   # Background and legal views
└── Resources/
    ├── Assets.xcassets/             # Image and color assets
    ├── Animations/                  # Lottie animation files
    ├── Fonts/                       # Custom font files
    ├── Info.plist                   # App configuration
    ├── Localizable.xcstrings        # Localization strings
    └── StoreConfiguration.storekit  # StoreKit configuration
```

## 🚀 Installation

This project uses **Swift Package Manager** for dependency management.

1. **Clone the repository:**

   ```bash
   git clone https://github.com/teenagelove/AIChat.git
   cd AIChat
   ```

2. **Open the Project:**

   ```bash
   open AIChat.xcodeproj
   ```

3. **Build and Run:**

   Select a simulator or device and press `Cmd + R` to build and run the project.

### ⚙️ Schemes

The project includes two schemes for different use cases:

| Scheme | Purpose | Subscriptions |
|--------|---------|---------------|
| `AIChat` | Production build | AppHud SDK (real or sandbox purchases) |
| `AIChat-StoreKitTest` | Local testing | StoreKit Configuration file (no network) |

To switch schemes, click the scheme selector in Xcode's toolbar and choose the desired scheme.

## 👥 Contributors

- [Danil Kazakov](https://github.com/teenagelove) - Creator and maintainer

## 📄 License

This project is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
