//
//  FoodAPI.m
//  Smart Device Developement Project
//
//  Created by ITP312 on 27/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FoodAPI.h"

@implementation RapidConnect : NSObject
+ (BOOL)downloadAPI:(NSString *)food
{
RapidConnect *rapid = [[RapidConnect alloc] initWithProjectName:@"default-application_5b331072e4b03a10f2281d8f" andToken:@"5d6cbeda-6c94-4ea0-b7b5-5697ccb99107"];

[rapid callPackage:@"Nutritionix" block:@"searchFoods" withParameters:[NSDictionary dictionaryWithObjectsAndKeys: @"a38a2ac0cfe3046b7a592c4723fb91ef", @"applicationSecret", food, @"foodDescription", @"42f9c7f2", @"applicationId", nil]
           success:^(NSDictionary *responseDict){
               NSLog(@"%@",responseDict);
           }failure:^(NSError *error){
               NSLog(@"%@",[error localizedDescription]);
           }];
}
@end
 
