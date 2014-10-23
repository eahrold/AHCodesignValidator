//
//  CodesignValidator_Tests.m
//  CodesignValidator_Tests
//
//  Created by Eldon on 10/22/14.
//  Copyright (c) 2014 Eldon Ahrold. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "AHCodesignValidator.h"

@interface AHCodesignValidator_Tests : XCTestCase

@end

@implementation AHCodesignValidator_Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMatch {
    NSError *error;
    // This is an example of a functional test case.
    NSString *item1 = @"/Applications/Server.app";
//    NSString *item2 = @"/Applications/MunkiMenu.app";
    NSString *item2 = @"/Library/PrivilegedHelperTools/com.apple.serverd";

    NSLog(@"%@ Signed with: %@",item1,[AHCodesignValidator certNameOfItemAtPath:item1 error:nil]);
    NSLog(@"%@ Signed with: %@",item2,[AHCodesignValidator certNameOfItemAtPath:item2 error:nil]);

    BOOL success = [AHCodesignValidator codesignOfItemAtPath:item1 isSameAsItemAtPath:item2 error:&error ];
    XCTAssert(success, @"%@",error);

    item1 = @"/Applications/Mail.app";
    item2 = @"/Applications/Preview.app";

    NSLog(@"%@ Signed with: %@",item1,[AHCodesignValidator certNameOfItemAtPath:item1 error:nil]);
    NSLog(@"%@ Signed with: %@",item2,[AHCodesignValidator certNameOfItemAtPath:item2 error:nil]);

    success = [AHCodesignValidator codesignOfItemAtPath:item1 isSameAsItemAtPath:item2 error:&error ];
    XCTAssert(success, @"%@",error);
}

- (void)testNotMatch {
    NSError *error;
    NSString *item1 = @"/Applications/Mail.app";
    NSString *item2 = @"/Applications/Firefox.app";
    NSLog(@"%@ Signed with: %@",item1,[AHCodesignValidator certNameOfItemAtPath:item1 error:nil]);
    NSLog(@"%@ Signed with: %@",item2,[AHCodesignValidator certNameOfItemAtPath:item2 error:nil]);


    BOOL success = [AHCodesignValidator codesignOfItemAtPath:item1 isSameAsItemAtPath:item2 error:&error ];
    if (error) {
        NSLog(@"Good, we got an error: %@",error.localizedDescription);
    }

    XCTAssertFalse(success, @"These should not be the same");

    error = nil;
    item1 = @"/Applications/Firefox.app";
    item2 = @"/Applications/Google Chrome.app";

    NSLog(@"%@ Signed with: %@",item1,[AHCodesignValidator certNameOfItemAtPath:item1 error:nil]);
    NSLog(@"%@ Signed with: %@",item2,[AHCodesignValidator certNameOfItemAtPath:item2 error:nil]);

    success = [AHCodesignValidator codesignOfItemAtPath:item1 isSameAsItemAtPath:item2 error:&error ];

    if (error) {
        NSLog(@"Good, we got an error: %@",error.localizedDescription);
    }

    XCTAssertFalse(success, @"These should not be the same");
}

- (void)testCodesignValidity {
    NSError *error;
    NSString *validPath = @"/Applications/Firefox.app";

    BOOL shouldSucceed = [AHCodesignValidator codeSignOfItemAtPathIsValid:validPath error:&error];
    XCTAssertTrue(shouldSucceed, @"%@",error.description);

    error = nil;
    NSString *invalidPath = @"/Applications/MacDown.app/";
    BOOL shouldFail = [AHCodesignValidator codeSignOfItemAtPathIsValid:invalidPath error:&error];

    if (error) {
        NSLog(@"Good, we got an error: %@",error.localizedDescription);
    }

    XCTAssertFalse(shouldFail, @"These should not be the same");



}

@end
