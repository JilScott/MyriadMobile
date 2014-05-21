//
//  Quest.h
//  MyriadMobileChallenge
//
//  Created by Jackie Scott on 5/6/14.
//  Copyright (c) 2014 Jilian Scott. All rights reserved.
//

#import <Foundation/Foundation.h> 


@interface Quest : NSObject

@property (strong, nonatomic) NSString *questTitle;
@property (nonatomic) int alignment;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSString *giver;
@property (nonatomic) float giverLatitude;
@property (nonatomic) float giverLongitude;
@property (nonatomic) float questLatitude;
@property (nonatomic) float questLongitude;
+(NSMutableArray*)presetQuests;

@end

