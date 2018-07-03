//
//  FoodAPI.h
//  Smart Device Developement Project
//
//  Created by ITP312 on 27/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

#ifndef FoodAPI_h
#define FoodAPI_h

//! Project version number for RapidConnectSDK.
FOUNDATION_EXPORT double RapidConnectSDKVersionNumber;

//! Project version string for RapidConnectSDK.
FOUNDATION_EXPORT const unsigned char RapidConnectSDKVersionString[];

/*
@interface FoodAPI : NSObject


+ (BOOL)downloadAPI:(NSString *)food;
*/

@interface RapidConnect : NSObject

@property (nonatomic, assign) NSString* baseUrl;
@property (nonatomic, assign) NSString* auth;


- (id)initWithProjectName:(NSString*)projectName andToken:(NSString*)token;
- (void)callPackage:(NSString*)package
              block:(NSString*)block
     withParameters:(NSDictionary*)parameters
            success:(void (^)(NSDictionary *responseDict))success
            failure:(void(^)(NSError* error))failure;


@end

#endif /* FoodAPI_h */
