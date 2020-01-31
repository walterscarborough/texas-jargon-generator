import Foundation

@objc class FakeURLProtocol: URLProtocol {
    static var testURLs = [URL?: Data]()
    static var response: URLResponse?
    static var error: Error?

    override class func canInit(with _: URLRequest) -> Bool {
        return true
    }

    override class func canInit(with _: URLSessionTask) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        if let url = request.url {
            if let data = FakeURLProtocol.testURLs[url] {
                client?.urlProtocol(self, didLoad: data)
            }
        }

        if let response = FakeURLProtocol.response {
            client?.urlProtocol(
                self,
                didReceive: response,
                cacheStoragePolicy: .notAllowed
            )
        }

        if let error = FakeURLProtocol.error {
            client?.urlProtocol(self, didFailWithError: error)
        }

        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {
        // No op
    }
}

extension FakeURLProtocol {
    class func resetState() {
        FakeURLProtocol.testURLs = [:]
        FakeURLProtocol.error = nil
        FakeURLProtocol.response = nil
    }

    class func createURLSession() -> URLSession {
        let urlSessionConfig = URLSessionConfiguration.ephemeral
        urlSessionConfig.protocolClasses = [FakeURLProtocol.self]
        let urlSession = URLSession(configuration: urlSessionConfig)

        return urlSession
    }
}
