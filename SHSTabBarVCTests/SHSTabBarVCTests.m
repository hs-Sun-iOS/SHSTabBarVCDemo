//
//  SHSTabBarVCTests.m
//  SHSTabBarVCTests
//
//  Created by sunhaosheng on 15/10/12.
//  Copyright © 2015年 孙浩胜. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface SHSTabBarVCTests : XCTestCase

@end

@implementation SHSTabBarVCTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        
        for (int i = 0;i < 100; i++) {
            static NSInteger sum = 0;
            sum = sum * i;
        }
    }];
}

@end
