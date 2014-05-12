//
//  QuestsAnnotation.m
//  MyriadMobileChallenge
//
//  Created by Jackie Scott on 5/12/14.
//  Copyright (c) 2014 Jilian Scott. All rights reserved.
//

#import "QuestsAnnotation.h"

@implementation QuestsAnnotation


-initWithPosition: (CLLocationCoordinate2D) coords
{
    if (self = [super init])
    {
         self.coordinate = coords;

    }
    return self;
}

@end
