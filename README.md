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