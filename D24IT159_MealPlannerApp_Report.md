# SMART MEAL PLANNER & NUTRITION TRACKING APP
## Mini Project Report

---

**Student Name:** Sudip Borad
**Student ID:** D24IT159
**Department:** Information Technology
**Subject:** Mobile Application Development (MAD)
**College:** Government Polytechnic
**Academic Year:** 2024–25
**Submission Date:** May 2025

---

## CERTIFICATE

This is to certify that the Mini Project **"Smart Meal Planner & Nutrition Tracking App"** is a bonafide work carried out by **Sudip Borad (D24IT159)** in partial fulfillment of the Diploma in Information Technology.

**Project Guide:** _________________________ **Signature:** _____________

**HOD:** _________________________ **Signature:** _____________

---

## ACKNOWLEDGEMENT

I sincerely thank my project guide and faculty of the Information Technology department for their valuable guidance. I am grateful to my college for providing the necessary infrastructure, and to my family and friends for their constant support throughout this project.

**Sudip Borad | D24IT159**

---

## ABSTRACT

The **Smart Meal Planner & Nutrition Tracking App** is a cross-platform mobile application developed using **Flutter**. It addresses the growing need for structured dietary management by allowing users to log meals, track calories and macronutrients, set personalized nutrition goals, and visualize eating trends through an analytics dashboard. Built on **Modular Clean Architecture** with **Riverpod** for state management and **Hive** for offline-first local storage, the app functions entirely without internet connectivity. The UI follows **Material 3 Design** principles, delivering a modern and intuitive experience. Key outcomes include a fully functional calorie tracker, offline data persistence, reactive UI, and a professional codebase committed to GitHub in four structured commits.

---

## TABLE OF CONTENTS

| # | Chapter | Description |
|---|---------|-------------|
| 1 | Introduction & Problem Statement | Background, need, and problem |
| 2 | Objectives & Scope | Goals and boundaries of the project |
| 3 | Literature Survey | Existing apps, gaps, justification |
| 4 | System Requirements | Hardware, software, functional, non-functional |
| 5 | System Architecture | Layers, data flow, state management |
| 6 | Module & Database Design | All modules and Hive data models |
| 7 | Calorie Logic & UI/UX Design | Calculations and screen descriptions |
| 8 | Offline Functionality & GitHub Workflow | Hive persistence and commit history |
| 9 | Testing & Advantages/Limitations | Test cases, pros, cons |
| 10 | Future Scope, Conclusion & References | Roadmap and closing |

---

## CHAPTER 1: INTRODUCTION & PROBLEM STATEMENT

### 1.1 Introduction

In today's fast-paced lifestyle, maintaining a healthy diet has become a significant challenge. Most individuals lack the tools to systematically plan meals, monitor calorie intake, or track macronutrients like protein, carbohydrates, and fats. Traditional methods such as handwritten food diaries are tedious and error-prone. Existing digital solutions often require internet connectivity, mandatory account registration, or paid subscriptions for core features.

The **Smart Meal Planner & Nutrition Tracking App** is a Flutter-based mobile application that solves these problems by offering a free, offline-first, and user-friendly platform for comprehensive nutrition management.

### 1.2 Problem Statement

The following core problems motivated the development of this application:

**Lack of Structured Meal Planning:** Most users consume meals without any systematic categorization (Breakfast, Lunch, Dinner, Snack), leading to inconsistent dietary habits and difficulty assessing their food intake.

**Difficulty Tracking Calories:** Manual calorie calculation requires looking up values for every food item, performing arithmetic, and manually recording data — a process most users abandon quickly due to its impracticality.

**No Centralized Nutrition Monitoring:** Users who wish to monitor calories, protein, carbs, and fats simultaneously have no single free tool that brings all metrics together in a cohesive, real-time dashboard.

**Dependency on Internet Connectivity:** Most commercial nutrition apps require an active internet connection, making them unusable in offline environments such as rural areas or institutions with restricted network access.

**Absence of Meaningful Analytics:** Existing free-tier apps rarely provide historical trend charts or weekly summaries, leaving users without the insights needed to make long-term dietary adjustments.

---

## CHAPTER 2: OBJECTIVES & SCOPE

### 2.1 Objectives

1. Enable users to **plan and log daily meals** categorized by type: Breakfast, Lunch, Dinner, and Snack.
2. Implement an **automatic calorie and macro calculator** based on selected food and entered quantity.
3. Provide a **goal-setting feature** where users define daily targets for calories, protein, carbs, and fats.
4. Build an **analytics dashboard** with weekly trend charts, goal achievement indicators, and macro distribution visualizations.
5. Implement **search and filter functionality** for previously logged meals.
6. Ensure **full offline operation** through Hive local database integration.
7. Deliver a **modern Material 3 UI** with smooth animations and intuitive navigation.
8. Maintain a **clean, modular codebase** with a structured four-commit GitHub history.

### 2.2 Scope

**In Scope:**
- Android mobile application (cross-platform via Flutter)
- Five main screens: Home, Add Meal, Track, Analytics, Search
- Pre-loaded food database (8 items) with quantity-based nutrition calculation
- Offline-first data persistence using Hive
- Real-time reactive state management using Riverpod
- Simulated offline sync mechanism

**Out of Scope:**
- User authentication / multi-user support
- Cloud database or real-time sync with a backend server
- AI-powered meal recommendations
- Barcode scanning for packaged food
- Wearable device integration

---

## CHAPTER 3: LITERATURE SURVEY

### 3.1 Existing Applications

| App | Strengths | Limitations |
|-----|-----------|-------------|
| **MyFitnessPal** | 14M+ food items, barcode scan, device sync | Premium-locked features, internet required, heavy UI |
| **Cronometer** | Detailed micronutrient data, accurate | Steep learning curve, account mandatory |
| **Lose It!** | Easy to use, goal-oriented | Core features paywalled, no offline mode |
| **Noom** | Behavioral coaching, personalized | Subscription only, not suitable for casual users |

### 3.2 Identified Gaps

| Gap | Existing Apps | This App |
|-----|--------------|----------|
| Offline Support | Limited / None | Full Offline (Hive) |
| Free Full Access | Paywalled | Completely Free |
| Clean Architecture | Undisclosed | Modular Clean Arch |
| Real-time Analytics | Premium Only | Included |
| Simple Interface | Often Complex | Material 3, Minimal |

### 3.3 Justification

The proposed application fills all identified gaps by providing a fully functional, free, and offline-capable nutrition tracker built with modern Flutter technologies. Its clean architecture makes it academically significant while its features make it practically useful.

---

## CHAPTER 4: SYSTEM REQUIREMENTS

### 4.1 Functional Requirements

| ID | Requirement |
|----|-------------|
| FR1 | User can log food items under meal types (Breakfast, Lunch, Dinner, Snack) |
| FR2 | App calculates calories, protein, carbs, fats based on food and quantity |
| FR3 | User can set and save daily nutritional goals |
| FR4 | App displays weekly calorie trend chart and goal progress |
| FR5 | User can search and filter logged meals by name and meal type |
| FR6 | App works fully offline; data persists across sessions |
| FR7 | User can delete any logged meal entry |

### 4.2 Non-Functional Requirements

| ID | Requirement | Detail |
|----|-------------|--------|
| NFR1 | Performance | UI response < 300ms; Hive reads < 100ms |
| NFR2 | Usability | Material 3 design; intuitive bottom navigation |
| NFR3 | Reliability | Zero data loss across app restarts |
| NFR4 | Scalability | Modular structure allows new feature addition |
| NFR5 | Maintainability | Separated UI, logic, and data layers |

### 4.3 Hardware & Software Requirements

**Hardware:**
- Android Smartphone (Android 6.0+), Minimum 2GB RAM, 50MB free storage

**Software:**

| Package | Version |
|---------|---------|
| Flutter SDK | 3.x Stable |
| Dart | 3.x |
| flutter_riverpod | 2.5.1 |
| hive / hive_flutter | 2.2.3 / 1.1.0 |
| fl_chart | 0.66.2 |
| uuid | 4.5.1 |
| intl | 0.19.0 |
| build_runner | 2.4.13 |
| hive_generator | 2.0.1 |

---

## CHAPTER 5: SYSTEM ARCHITECTURE

### 5.1 Architectural Layers

The app follows **Modular Clean Architecture** with four distinct layers:

```
┌────────────────────────────────────┐
│       PRESENTATION LAYER           │
│  Flutter Screens + Widgets         │
├────────────────────────────────────┤
│      STATE MANAGEMENT LAYER        │
│      Riverpod Providers            │
├────────────────────────────────────┤
│         DOMAIN LAYER               │
│   Data Models + Calculations       │
├────────────────────────────────────┤
│           DATA LAYER               │
│  HiveRepository + Hive Boxes       │
└────────────────────────────────────┘
```

**Presentation Layer:** All Flutter UI screens (`ConsumerWidget`) that watch Riverpod providers and rebuild reactively on state changes.

**State Management Layer:** Riverpod providers compute derived state (daily calorie totals, filtered lists, progress percentages) and expose actions (addMeal, deleteMeal, updateGoal).

**Domain Layer:** Pure Dart models (`FoodItem`, `MealEntry`, `NutritionGoal`) and utility classes (`Calculations`) with no external dependencies.

**Data Layer:** `HiveRepository` encapsulates all read/write operations on Hive Boxes, keeping providers clean and testable.

### 5.2 Data Flow

```
User taps "Save Meal"
     │
     ▼
FoodEntryScreen validates form
     │ calls
     ▼
mealProvider.addMeal(MealEntry)
     │ calls
     ▼
HiveRepository.addMeal()  →  Hive Box<MealEntry>
     │
     ▼
Riverpod state updates → All screens rebuild instantly
```

### 5.3 Key Riverpod Providers

| Provider | Type | Purpose |
|----------|------|---------|
| `mealProvider` | StateNotifierProvider | CRUD for MealEntry list |
| `goalProvider` | StateNotifierProvider | User's NutritionGoal state |
| `dailyCaloriesProvider` | Provider | Sum of today's consumed calories |
| `calorieRemainingProvider` | Provider | Goal minus consumed |
| `calorieProgressProvider` | Provider | consumed / goal (0.0–1.0) |
| `weeklyTrendProvider` | Provider | List of 7 daily calorie values |
| `filteredMealsProvider` | Provider | Search + filter applied meals |
| `navIndexProvider` | StateProvider | Active bottom nav tab index |

---

## CHAPTER 6: MODULES & DATABASE DESIGN

### 6.1 Module Descriptions

**a) Meal Planning Module**
- **Purpose:** Home screen for viewing and managing daily meals
- **Inputs:** Logged meals from Hive, user gestures
- **Outputs:** Calorie summary card, categorized meal cards with macro badges
- **Key Features:** Delete meals (updates Hive + UI instantly), navigate to Add Meal, floating action button

**b) Nutrition Tracking Module**
- **Purpose:** Full daily overview of calorie and macro intake
- **Inputs:** All MealEntry objects, NutritionGoal
- **Outputs:** Summary panel, three macro tiles (Protein/Carbs/Fats), meal timeline
- **Key Features:** Dynamic progress bar, color-coded timeline dots per meal type

**c) Goal Setting Module**
- **Purpose:** Define and persist daily nutritional targets
- **Inputs:** User-entered calorie, protein, carbs, fats targets
- **Outputs:** Persisted NutritionGoal in Hive; all progress indicators update reactively
- **Defaults:** 2000 kcal, 120g protein, 250g carbs, 60g fats

**d) Analytics Dashboard Module**
- **Purpose:** Visual dietary trend analysis
- **Inputs:** weeklyTrendProvider, calorieProgressProvider, macro providers
- **Outputs:** fl_chart LineChart (7-day), circular progress ring, stacked macro bar
- **Key Features:** Dashed goal line on chart, real-time data binding

**e) Food Database Module**
- **Purpose:** Provide base nutritional values per 100g for common foods
- **Items:** Rice (Cooked), Oats, Banana, Egg, Chicken Breast, Milk, Whole Wheat Bread, Apple
- **Outputs:** Autocomplete suggestions in Food Entry screen

**f) Search & Filter Module**
- **Purpose:** Find previously logged meals
- **Inputs:** Text query (`searchQueryProvider`), meal type chip (`searchMealTypeProvider`)
- **Outputs:** `filteredMealsProvider` — reactive filtered list, updates without button press

**g) Offline Storage Module**
- **Purpose:** Ensure zero data loss across app sessions
- **Inputs:** MealEntry and NutritionGoal objects
- **Outputs:** Persistent Hive Boxes; state loaded on launch from local storage

### 6.2 Database Design (Hive Models)

#### FoodItem (typeId: 0)

| Field | Type | Purpose |
|-------|------|---------|
| id | String | Unique identifier |
| name | String | Display name |
| calories | int | Kcal per 100g |
| protein | int | Protein grams per 100g |
| carbs | int | Carb grams per 100g |
| fats | int | Fat grams per 100g |

#### MealEntry (typeId: 1)

| Field | Type | Purpose |
|-------|------|---------|
| id | String | UUID (unique per entry) |
| foodId | String | Reference to FoodItem |
| foodName | String | Snapshot at log time |
| mealType | String | Breakfast/Lunch/Dinner/Snack |
| quantity | int | Grams entered by user |
| totalCalories | int | Calculated for quantity |
| protein | int | Calculated for quantity |
| carbs | int | Calculated for quantity |
| fats | int | Calculated for quantity |
| createdAt | DateTime | Timestamp of log |

#### NutritionGoal (typeId: 2)

| Field | Type | Purpose |
|-------|------|---------|
| calorieGoal | int | Daily calorie target |
| proteinGoal | int | Daily protein target (g) |
| carbsGoal | int | Daily carbs target (g) |
| fatsGoal | int | Daily fats target (g) |

**Hive Boxes:**

| Box Name | Type | Usage |
|----------|------|-------|
| mealsBox | Box\<MealEntry\> | All logged meals |
| goalBox | Box\<NutritionGoal\> | User's current goals |

---

## CHAPTER 7: CALORIE LOGIC & UI/UX DESIGN

### 7.1 Calorie Calculation Logic

All nutritional values in the food database are stored per **100g**. When a user enters a custom quantity, values are scaled proportionally:

```
calculatedValue = (baseValue / 100) × enteredQuantity
```

**Example:** Chicken Breast has 165 kcal per 100g. User enters 200g:
```
totalCalories = (165 / 100) × 200 = 330 kcal
```

The same formula applies to protein, carbs, and fats.

**Goal Progress Formula:**
```
goalProgress = consumedCalories / targetCalories × 100
```

This value (clamped between 0–100%) is used to fill the circular progress indicator and linear progress bars.

**Daily Total:**
```
dailyTotal = Σ totalCalories of all MealEntry objects logged today
remaining  = calorieGoal − dailyTotal  (minimum 0)
```

**Weekly Analytics:**
The `weeklyTrendProvider` returns a list of 7 `double` values representing each day's total calorie intake. The current day's value is populated dynamically from `dailyCaloriesProvider`.

### 7.2 UI/UX Screen Descriptions

**Home Screen (MealPlanningScreen)**
- Gradient app bar with personalized greeting and date
- Circular `CalorieSummaryCard` with consumed/goal/remaining stats
- Four meal-type sections each with "+ Add" shortcut
- Meal cards showing food name, quantity, and four macro badges
- Delete icon on each card; FAB for quick meal addition
- Sync icon button triggers simulated offline → cloud sync

**Add Meal Screen (FoodEntryScreen)**
- Dropdown for meal type selection
- Autocomplete search field connected to `foodDatabaseProvider`
- Quantity input field with real-time macro preview update
- Auto-calculated calories displayed prominently in a green card
- Three macro preview tiles (Protein, Carbs, Fat) update instantly
- Form validation: blocks empty food selection and zero/negative quantities
- "Save Meal" triggers Riverpod state update + Hive write + Snackbar

**Daily Tracking Screen (TrackingScreen)**
- Large summary panel: Consumed | Daily Goal | Remaining
- Dynamic progress bar with percentage label
- Three `NutrientTile` cards: Protein, Carbs, Fats (each with gradient progress bars)
- Chronological meal timeline with color-coded category dots and connecting lines

**Analytics Screen (AnalyticsScreen)**
- Weekly/Monthly tab switcher in app bar
- Three insight cards: Avg Daily, Best Day, Goal Rate
- `fl_chart` LineChart with 7 data points and dashed goal reference line
- Circular achievement ring with legend (Goals Met, Over Goal, Under Goal)
- Proportional nutrient distribution bar (Protein | Carbs | Fat)

**Search & Filter Screen (SearchFilterScreen)**
- Embedded search bar in app bar for live filtering
- Meal type filter chips (All, Breakfast, Lunch, Dinner, Snack)
- Date filter chips (Today, This Week)
- Result count label updates dynamically
- Result cards showing food emoji, name, meal type badge, date, and calories

---

## CHAPTER 8: OFFLINE FUNCTIONALITY & GITHUB WORKFLOW

### 8.1 Offline Functionality

The application follows an **offline-first architecture**, meaning all data operations are performed against the local Hive database with no network dependency.

**Hive Initialization (main.dart):**
```dart
await Hive.initFlutter();
Hive.registerAdapter(FoodItemAdapter());
Hive.registerAdapter(MealEntryAdapter());
Hive.registerAdapter(NutritionGoalAdapter());
await Hive.openBox<MealEntry>('mealsBox');
await Hive.openBox<NutritionGoal>('goalBox');
```

**Data Persistence Flow:**
1. On app launch, `MealNotifier` calls `_loadMeals()` → reads all entries from `mealsBox` → populates Riverpod state
2. `GoalNotifier` reads saved goal from `goalBox` at initialization; falls back to defaults if none found
3. Every `addMeal()` and `deleteMeal()` call writes to Hive first, then updates in-memory Riverpod state
4. All screens rebuild reactively via Riverpod without any manual refresh

**Sync Simulation:**
`SyncService` simulates a 2-second network delay to represent future cloud synchronization. A loading SnackBar is shown during sync, followed by a success message. The `isSyncingProvider` prevents duplicate sync requests.

### 8.2 GitHub Commit Workflow

The project was developed in four structured commits on the repository: `https://github.com/Sudipborad/MAD_EXTERNAL_sudip.git`

**Commit 1 — Project Initialization and Architecture Setup**
- Initialized Flutter project `meal_planner`
- Added all dependencies to `pubspec.yaml`
- Created modular directory structure: `lib/core`, `lib/models`, `lib/providers`, `lib/screens`, `lib/widgets`, `lib/services`
- Implemented `AppColors`, `AppTheme` (Material 3)
- Created five placeholder screens with bottom navigation
- Set up `main.dart` with `ProviderScope` and Hive initialization

**Commit 2 — UI Implementation for Meal Planner Application**
- Implemented full UI for all 5 screens based on HTML demo references
- Created reusable widgets: `CalorieSummaryCard`, `MealCard`, `NutrientTile`, `AnalyticsChart`
- Applied gradient app bars, Material 3 cards, and smooth shadows
- Styled bottom `NavigationBar` with green selection indicator
- Added `UI_DEMO SCREENS/` to `.gitignore`

**Commit 3 — Core Logic for Meal and Nutrition Tracking**
- Created `FoodItem`, `MealEntry`, `NutritionGoal` data models
- Implemented all Riverpod providers: `mealProvider`, `goalProvider`, `foodDatabaseProvider`, `analyticsProvider`, `searchProvider`, `navIndexProvider`
- Built `Calculations` utility class for proportional macro computation
- Integrated Autocomplete food search with real-time macro preview in `FoodEntryScreen`
- Connected all screens to live Riverpod state with form validation and Snackbars

**Commit 4 — Offline Storage Integration and Final Enhancements**
- Annotated models with `@HiveType` and `@HiveField` decorators
- Ran `build_runner` to generate Hive TypeAdapters (`.g.dart` files)
- Created `HiveRepository` for clean data layer abstraction
- Updated `MealNotifier` and `GoalNotifier` to persist state in Hive
- Implemented `SyncService` with simulated offline-to-cloud sync
- Added sync icon button to Home screen with loading and success SnackBars
- Fixed `CardThemeData` and import path bugs for cross-platform compatibility

---

## CHAPTER 9: TESTING, ADVANTAGES & LIMITATIONS

### 9.1 Testing

#### Functional Testing

| Test Case | Input | Expected Result | Actual Result | Status |
|-----------|-------|----------------|---------------|--------|
| TC01: Add Meal | Select "Chicken Breast", 200g, Lunch | Entry appears on Home & Tracking screens; +330 kcal shown | Entry added correctly | ✅ Pass |
| TC02: Calorie Update | Add any meal | Daily calorie total and progress bar update instantly | Updated in real-time | ✅ Pass |
| TC03: Delete Meal | Tap delete on a meal card | Meal removed from list; calorie total decreases | Removed correctly | ✅ Pass |
| TC04: Goal Progress | Set goal 2000 kcal, consume 1000 kcal | Progress = 50%, bar half-filled | 50% shown correctly | ✅ Pass |
| TC05: Data Persistence | Add meal, close and reopen app | Meal still present on Home screen | Data persisted via Hive | ✅ Pass |
| TC06: Search Filter | Type "chicken" in search bar | Only chicken-related entries shown | Filtered correctly | ✅ Pass |
| TC07: Meal Type Filter | Select "Breakfast" chip | Only breakfast entries shown | Filtered correctly | ✅ Pass |
| TC08: Sync Button | Tap sync icon | Loading SnackBar for 2s, then success SnackBar | Simulated correctly | ✅ Pass |

#### Validation Testing

| Test Case | Input | Expected Behaviour | Status |
|-----------|-------|-------------------|--------|
| TV01: Empty food field | Submit without selecting food | Form shows "Please select a valid food item" | ✅ Pass |
| TV02: Zero quantity | Enter 0 in quantity field | Form shows "Must be > 0" | ✅ Pass |
| TV03: Negative quantity | Enter -50 | Form shows validation error | ✅ Pass |
| TV04: Non-numeric quantity | Enter "abc" | Form shows validation error | ✅ Pass |

### 9.2 Advantages

1. **Offline-First:** Works completely without internet connectivity; data persists in Hive
2. **Real-Time Updates:** Riverpod propagates state changes instantly to all screens
3. **User-Friendly UI:** Material 3 design with gradients, cards, and smooth animations
4. **Automatic Calculations:** Calories and macros computed proportionally with zero manual effort
5. **Free & Open:** No subscriptions or account registration required
6. **Clean Architecture:** Modular structure makes the codebase easy to maintain and extend
7. **Analytics Dashboard:** Weekly trend charts and macro distribution give meaningful dietary insights
8. **Form Validation:** Prevents invalid meal entries with helpful error messages

### 9.3 Limitations

1. **Limited Food Database:** Only 8 pre-loaded food items; requires manual addition for other foods
2. **No AI Recommendations:** Meal suggestions are not generated based on goals or past habits
3. **Basic Analytics:** Weekly trends use approximated dummy data for past days; only today's data is live
4. **Single User:** No multi-user or profile management support
5. **No Barcode Scanning:** Packaged foods cannot be scanned for automatic nutritional data import
6. **Simulated Sync:** Cloud synchronization is a mock implementation with no real backend

---

## CHAPTER 10: FUTURE SCOPE, CONCLUSION & REFERENCES

### 10.1 Future Scope

| Feature | Description |
|---------|-------------|
| **AI Meal Suggestions** | Use machine learning to recommend meals based on nutritional goals and past habits |
| **Barcode Scanning** | Integrate device camera with a food API (Open Food Facts) to auto-fill nutrition info |
| **Cloud Synchronization** | Connect to Firebase or Supabase for real-time multi-device sync and backup |
| **Wearable Integration** | Sync with Google Fit, Apple Health, or smartwatches for step count and calorie burn |
| **Advanced Analytics** | Monthly reports, calorie deficit/surplus tracking, body weight correlation graphs |
| **Meal Templates** | Save and reuse favorite meal combinations with a single tap |
| **Water Intake Tracking** | Add hydration monitoring alongside food tracking |
| **Push Notifications** | Remind users to log meals at regular intervals throughout the day |

### 10.2 Conclusion

The **Smart Meal Planner & Nutrition Tracking App** successfully demonstrates the development of a fully functional, offline-first, and visually polished Flutter mobile application. The project addressed real-world challenges in nutrition management by combining a clean architectural approach with modern Flutter technologies.

**Project Achievements:**
- A complete five-screen application with full CRUD functionality for meal tracking
- Real-time calorie and macro calculation using proportional math
- Persistent local storage via Hive, ensuring data survives app restarts
- Reactive state management with Riverpod that eliminates manual refresh logic
- An analytics dashboard with fl_chart visualizations for dietary trend analysis
- A professional codebase organized in four meaningful GitHub commits

**Learning Outcomes:**
Through this project, the developer gained hands-on experience with:
- Flutter widget lifecycle and custom widget creation
- State management patterns using Riverpod (StateNotifier, Provider, ConsumerWidget)
- NoSQL local database integration using Hive and code generation with build_runner
- Modular clean architecture applied to a real-world application
- Git version control with structured, meaningful commit messages
- Material 3 design principles including gradients, elevation, and micro-interactions

**Benefits of the Application:**
The app empowers users to take control of their dietary habits without requiring internet access, technical expertise, or financial investment. It serves as both a practical nutrition tool and a demonstration of professional-grade Flutter development practices applicable in industry settings.

---

### 10.3 References

1. **Flutter Official Documentation** — https://docs.flutter.dev
   *Google's comprehensive guide to Flutter widgets, layout, and state management.*

2. **Hive Database Documentation** — https://docs.hivedb.dev
   *Official documentation for Hive, covering box setup, TypeAdapters, and queries.*

3. **Riverpod Documentation** — https://riverpod.dev/docs
   *Complete reference for Riverpod providers, StateNotifier, and ConsumerWidget.*

4. **Material 3 Design Guidelines** — https://m3.material.io
   *Google's design system specification for color, typography, and components.*

5. **fl_chart Package** — https://pub.dev/packages/fl_chart
   *Flutter charting library documentation for LineChart, BarChart, and PieChart.*

6. **pub.dev — Flutter Package Repository** — https://pub.dev
   *Official Dart/Flutter package registry used for all project dependencies.*

7. **Dart Language Documentation** — https://dart.dev/guides
   *Official Dart language reference covering syntax, async/await, and generics.*

8. **World Health Organization (WHO) — Healthy Diet Fact Sheet** — https://www.who.int/news-room/fact-sheets/detail/healthy-diet
   *Source for nutritional importance and dietary disease statistics cited in Chapter 1.*

---

*End of Report*

**Student:** Sudip Borad | **ID:** D24IT159 | **Date:** May 2025
