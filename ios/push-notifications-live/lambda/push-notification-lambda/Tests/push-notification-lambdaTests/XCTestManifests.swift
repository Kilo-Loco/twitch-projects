import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(push_notification_lambdaTests.allTests),
    ]
}
#endif
