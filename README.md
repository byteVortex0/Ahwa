☕ Ahwa Manager

Ahwa Manager is a simple Flutter app for managing coffee shop orders.
The main goal of this project is not the design but rather to practice OOP principles and apply SOLID clean architecture in a real project.

🎯 Project Goals

Practice applying OOP in Flutter (classes, inheritance, abstraction, encapsulation, composition).

Implement SOLID clean architecture to improve code readability, testability, and maintainability.

Build a small but structured app that demonstrates how principles can be applied to a real project.

🧩 OOP Principles in Action

Encapsulation → Models like Drink, Order, and User manage their own state and behaviors.

Abstraction → Applied in OrdersRepo and ReportRepo.

Polymorphism → Different repo implementations can be used interchangeably.

🔑 SOLID Principles Applied

S (Single Responsibility Principle) → Each class, like OrdersRepoImpl, has one clear responsibility.

O (Open/Closed Principle) → New drink types can be added without modifying existing code.

L (Liskov Substitution Principle) → Any repo implementation can substitute another without breaking functionality.

I (Interface Segregation Principle) → Repos were split into smaller contracts like OrdersRepo and ReportRepo.

D (Dependency Inversion Principle) → Cubits depend on abstractions (Repo) instead of concrete implementations.

📌 The app allows you to:

Add new orders with customer name, drink type, and special instructions.

Track orders (pending & completed).

Mark orders as completed.

Generate simple reports such as top-selling drinks.

🚀 Features

✅ Local database using sqflite

✅ Repository pattern

✅ Cubit/Bloc for state management

✅ Applying OOP & SOLID principles (abstraction, single responsibility, dependency injection, etc.)

✅ Simple chart for top 3 best-selling drinks

📂 Project Structure
data/   → models, repositories  
logic/  → cubits (state management)  
ui/     → pages, widgets  
core/   → shared services, DB helper, di  



#FlutterMentors3
