import Foundation

extension URLSession {

    func dataTask(for urlRequest: URLRequest) async throws -> (Data, URLResponse) {
        try Task.checkCancellation()
        return try await withCheckedThrowingContinuation { continuation in
            let task = self.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let data = data, let response = response {
                    continuation.resume(returning: (data, response))
                } else {
                    let unknowError = NSError(domain: "Unknow Error", code: 0, userInfo: nil)
                    continuation.resume(throwing: unknowError)
                }
            }

            task.resume()
        }
    }
}
