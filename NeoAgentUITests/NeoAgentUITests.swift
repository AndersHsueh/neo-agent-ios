import XCTest

final class NeoAgentUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testAppLaunchesToOnboarding() {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.staticTexts["连接 neo 后端"].waitForExistence(timeout: 10))
    }
}
