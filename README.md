# fetch-code-challenge

# Setup
1. Install [Xcode 16.2.0](https://xcodereleases.com)

2. Clone the project
```sh
git clone https://github.com/khaptonstall/fetch-code-challenge.git
```

3. Open `CodeChallenge.xcworkspace` in Xcode
```sh
cd fetch-code-challenge
xed CodeChallenge.xcworkspace
```

4. Select the `CodeChallenge` Scheme, then build and run to an iOS device target

# Project Overview

For details, see [Fetch Mobile Take Home Project](https://d3jbb8n5wk0qxi.cloudfront.net/take-home-project.html).

### Summary: Include screen shots or a video of your app highlighting its features

The `CodeChallenge` app is a fully modularized SwiftUI app that displays a list of recipes (including their name, cuisine type, and photos) from a [remote server](https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json).

The project consists of the following:
- `CodeChallege` app target
- `Networking` library for simple HTTP requests
  - `MockNetworking`  library to enable easy HTTP mocking for testing
- `RemoteImage` library providing a SwiftUI `Image` variation for loading & caching of images
- A `Recipes` feature library that includes separate targets for both the UI (`RecipesUI`) and API (`RecipesAPI`)

#### Demo Walkthrough

Below is a walkthrough of the app experience. Contained in the video is both the app and a running instance of Proxyman to help simulate various network responses and demonstrate how the app responds.

The demo will go through the following scenarios, in order:
1. Loading the full recipes list
2. Handling a scenario where no recipes are returned
3. Handling a scenario where the recipes data is malformed
4. Reloading the full recipes list again

➡️ See Demo in [Assets/Demo.mov](Assets/Demo.mov)

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

- Project Modularization
  - Structuring the project to have clear boundaries between networking, caching, and even individual app features to ensure the codebase is easy to read and reason about, maintain, test, and scale.
- Network Testability
  - The goal with creating the `MockNetworking` library was to support ease of network testability with a modularized project structure, given both the core `Networking` framework and feature modules would benefit from such functionality.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

Time spent: ~6.5hrs

Approximate breakdown:
- Project planning (e.g. mapping out project architecture, kanban board breaking down deliverables, etc.): ~0.5hr
- Initial project setup (e.g. creating repository, workspace layout, build settings, etc.): ~0.5hr
- Building `Networking` and `MockNetworking`: ~2.5hrs
- Building `RecipesAPI` and `RecipesUI`: ~2hrs
- Building `RemoteImage` package: ~1hr


### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

One trade-off I made was keeping the UI relatively simple so I could focus on building a well-separated set of core libraries. Given the data available, there were plenty of potential enhancements that I chose to defer in favor of core functionality:
- Filtering via `cuisine` type
- Searching by name
- More focus on highlighting recipe images
- Providing access to recipe source and Youtube videos

### Weakest Part of the Project: What do you think is the weakest part of your project?

- The `RemoteImage` framework was the final addition and contains _just_ enough functionality to meet the caching requirements for this project. While provides a modern interface, is efficient, and is thread-safe, there is a lot of room for improvement if this were to truly be a shared library:
  - Does not provide flexibility in the user experience for custom placeholders and handling of download errors
  - No way to manage the cache (e.g. clear items, set limits or policies)
  - Lacks support for more advanced caching strategies (e.g. expiry rules or storage limits)
