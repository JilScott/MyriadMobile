//
//  QuestsAnnotation.h
//  MyriadMobileChallenge
//
//  Created by Jackie Scott on 5/12/14.
//  Copyright (c) 2014 Jilian Scott. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface QuestsAnnotation : NSObject <MKAnnotation>

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *subtitle;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
-initWithPosition: (CLLocationCoordinate2D) coords;

@end
