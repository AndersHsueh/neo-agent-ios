import XCTest
@testable import NeoAgent

final class ConnectionProfileTests: XCTestCase {
    func testBaseURLUsesHTTPWhenTLSDisabled() {
        let profile = ConnectionProfile(host: "192.168.1.10", port: 8787, usesTLS: false)
        XCTAssertEqual(profile.baseURL.absoluteString, "http://192.168.1.10:8787")
    }

    func testBaseURLUsesHTTPSWhenTLSEnabled() {
        let profile = ConnectionProfile(host: "neo.local", port: 443, usesTLS: true)
        XCTAssertEqual(profile.baseURL.absoluteString, "https://neo.local:443")
    }
}
