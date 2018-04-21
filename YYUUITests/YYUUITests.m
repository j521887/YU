#import <XCTest/XCTest.h>
@interface YYUUITests : XCTestCase
@end
@implementation YYUUITests
- (void)setUp {
    [super setUp];
    self.continueAfterFailure = NO;
    [[[XCUIApplication alloc] init] launch];
}
- (void)tearDown {
    [super tearDown];
}
- (void)testExample {
}
@end
