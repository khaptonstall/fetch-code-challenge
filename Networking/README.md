# Networking

The `Networking` target provides basic support for performing URL requests. Note, at this time it only supports simple GET requests with no query parameters.

## Usage

1. Define an individual `NetworkRequest`, which defines a `URLRequest` to perform, validation to run against the response, and instructions for parsing the response data:

```swift
import Foundation
import Networking

/// Defines a GET request to return a list of MyResource
struct GetMyResource: NetworkRequest {
    let responseValidators: [URLResponseValidator] = [StatusCodeValidator()]

    func makeRequest() throws -> URLRequest {
        return try URLRequest.makeRequest(
            url: "https://my.domain.com/resource",
            method: .get
        )
    }
    
    func parseResponse(data: Data) throws -> [MyResource] {
        try JSONDecoder().decode([MyResource].self, from: data)
    }
}
```

2. Use a `NetworkRequestPerformer` to perform your request:
   
```swift
let requestPerformer = NetworkRequestPerfomer()
let myResources: [MyResource] = try await requestPerformer.performRequest(GetMyResource())
```