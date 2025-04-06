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

### Summary: Include screen shots or a video of your app highlighting its features

The `CodeChallenge` app is a fully modularized SwiftUI app for displaying a list of recipes (including their name, cuisine type, and photos) from a [remote server](https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json).

The project is composed of the following:
- `CodeChallege` app target
- `Networking` library for simple HTTP requests
  - `MockNetworking`  library to enable easy HTTP mocking for testing
- `RemoteImage` library providing a SwiftUI `Image` variation for loading & caching of images
- A `Recipes` feature library that includes separate targets for both the UI (`RecipesUI`) and API (`RecipesAPI`)

#### Demo Walkthrough

Below is a walkthrough of the app experience. Contained in the video is both the app and a running instance of Proxyman to help simulate various network responses and demonstrate how the app responds.

The demo wil go through the following scenarios, in order:
1. Loading the full recipes list
2. Handling a scenario where no recipes are returned
3. Handling a scenario where the recipes data is malformed
4. Reloading the full recipes list again

![](Assets/Demo.mov)


### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

### Weakest Part of the Project: What do you think is the weakest part of your project?

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.