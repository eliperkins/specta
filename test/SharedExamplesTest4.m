#import "TestHelper.h"

SpecBegin(_SharedExamplesTest4)

__block __weak NSString *foo = nil;

beforeEach(^{
  foo = @"bar";
});

itShouldBehaveLike(@"shared example with data supplied from beforeEach", ^{
  return @{@"foo": foo};
});

itShouldBehaveLike(@"shared example that does not capture the data dictionary", ^{
  return @{@"foo": @"bar"};
});

SpecEnd

SharedExamplesBegin(_SharedExamplesTest4)

sharedExamples(@"shared example with data supplied from beforeEach", ^(NSDictionary *data) {
  it(@"inserts data.baz to items", ^{
    SPTAssertEqualObjects(data[@"foo"], @"bar");
  });
});

sharedExamples(@"shared example that does not capture the data dictionary", ^(NSDictionary *data) {
  it(@"should not fail", ^{});
});

SharedExamplesEnd

@interface SharedExamplesTest4 : XCTestCase; @end
@implementation SharedExamplesTest4

- (void)testSharedExamples {
  XCTestSuiteRun *result = RunSpec(_SharedExamplesTest4Spec);
  SPTAssertEqual([result testCaseCount], 2);
  SPTAssertEqual([result unexpectedExceptionCount], 0);
  SPTAssertEqual([result failureCount], 0);
  SPTAssertTrue([result hasSucceeded]);
}

@end
