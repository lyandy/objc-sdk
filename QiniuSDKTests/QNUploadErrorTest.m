//
//  QNUploadErrorTest.m
//  QiniuSDK
//
//  Created by yangsen on 2020/5/11.
//  Copyright © 2020 Qiniu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <AGAsyncTestHelper.h>
#import "QiniuSDK.h"
#import "QNTempFile.h"
#import "QNTestConfig.h"

@interface QNUploadErrorTestParam : NSObject

@property(nonatomic,   copy)NSString *token;
@property(nonatomic,   copy)NSString *key;
@property(nonatomic, strong)QNTempFile *tempFile;

@end
@implementation QNUploadErrorTestParam
+ (instancetype)param{
    QNUploadErrorTestParam *p = [[QNUploadErrorTestParam alloc] init];
    p.token = g_token;
    p.key = @"upload_error_128K";
    p.tempFile = [QNTempFile createTempfileWithSize:128 * 1024 identifier:p.key];
    return p;
}
@end

@interface QNUploadErrorTest : XCTestCase

@end

@implementation QNUploadErrorTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testError_400 {
    
    QNUploadErrorTestParam *param = [QNUploadErrorTestParam param];
    param.token = @"jH983zIUFIP1OVumiBVGeAfiLYJvwrF45S-t22eu:5Ee-ICYAd_SAZKO_DLfyJQVHsQ=:eyJzY29wZSI6InpvbmUwLXNwYWNlIiwiZGVhZGxpbmUiOjE1ODkyNjAxNzR9";
    
    __block BOOL isComplete = NO;
    [self upload:param complete:^(QNResponseInfo *i, NSString *k, NSDictionary *resp) {
        
        XCTAssert(i.statusCode == 401, @"Pass");
        isComplete = YES;
    }];
    
    AGWW_WAIT_WHILE(isComplete == NO, 60 * 30);
}

- (void)testError_401{
    
}

- (void)testError_403{
    
}

- (void)testError_404{
    
}

- (void)testError_406{
    
}

- (void)testError_413{
    
}

- (void)testError_419{
    
}

- (void)testError_478{
    
}

- (void)testError_502{
    
}

- (void)testError_503{
    
}

- (void)testError_504{
    
}

- (void)testError_573{
    
}

- (void)testError_579{
    
}

- (void)testError_599{
    
}

- (void)testError_608{
    
}

- (void)testError_612{
    
}

- (void)testError_614{
    QNUploadErrorTestParam *param = [QNUploadErrorTestParam param];
    param.tempFile = [QNTempFile createTempfileWithSize:128];
    
    __block BOOL isComplete = NO;
    [self upload:param complete:^(QNResponseInfo *i, NSString *k, NSDictionary *resp) {
        
        XCTAssert(i.statusCode == 614, @"Pass");
        isComplete = YES;
    }];
    
    AGWW_WAIT_WHILE(isComplete == NO, 60 * 30);
}

- (void)testError_630{
    
}

- (void)testError_631{
    
    QNUploadErrorTestParam *param = [QNUploadErrorTestParam param];
    param.token = @"jH983zIUFIP1OVumiBVGeAfiLYJvwrF45S-t22eu:mnkuT6Y_k3UaKMMs2qYROs6yqjs=:eyJzY29wZSI6InpvbmV0ZXN0LXNwYWNlIiwiZGVhZGxpbmUiOjE1ODkyNzU5NDN9";
    
    __block BOOL isComplete = NO;
    [self upload:param complete:^(QNResponseInfo *i, NSString *k, NSDictionary *resp) {
        
        XCTAssert(i.statusCode == 631, @"Pass");
        isComplete = YES;
    }];
    
    AGWW_WAIT_WHILE(isComplete == NO, 60 * 30);
}

- (void)testError_640{
    
}

- (void)testError_701{
    
}

- (void)upload:(QNUploadErrorTestParam *)param
      complete:(void(^)(QNResponseInfo *i, NSString *k, NSDictionary *resp))complete{
    
    QNConfiguration *config = [QNConfiguration build:^(QNConfigurationBuilder *builder) {
        builder.useConcurrentResumeUpload = YES;
        builder.concurrentTaskCount = 3;
    }];
    QNUploadManager *upManager = [[QNUploadManager alloc] initWithConfiguration:config];
    
    QNUploadOption *opt = [[QNUploadOption alloc] initWithProgressHandler:^(NSString *key, float percent) {
        NSLog(@"progress %f", percent);
    }];
    
    [upManager putFile:param.tempFile.fileUrl.path key:param.key token:param.token complete:^(QNResponseInfo *i, NSString *k, NSDictionary *resp) {
        
        complete(i, k, resp);
    } option:opt];
    
    [param.tempFile remove];
}

@end
