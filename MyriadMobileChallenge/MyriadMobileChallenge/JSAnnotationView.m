//
//  JSAnnotationView.m
//  MyriadMobileChallenge
//
//  Created by Jackie Scott on 5/13/14.
//  Copyright (c) 2014 Jilian Scott. All rights reserved.
//

#import "JSAnnotationView.h"
#import "QuestsAnnotation.h"

@implementation JSAnnotationView

-(id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    //assigning map markers based on being a Quest Objective or Quest Poster
    QuestsAnnotation *myAnnotation = (QuestsAnnotation *)annotation;
    NSString *myImage;
    if ([myAnnotation.type isEqualToString:@"Poster"])
    {
        myImage = @"knightHead1.jpg";
    }
    else if ([myAnnotation.type isEqualToString:@"Quest"])
    {
        myImage = @"sword2.jpg";
    }
    self.image = [UIImage imageNamed:myImage];
    
        //assigning lefthand image for different quests within annotations
    NSString *accessoryImage;
    if ([myAnnotation.title isEqualToString:@"Filthy Mongrel"] | [myAnnotation.title isEqualToString:@"Prince Jack, The Iron Horse"])
    {
        accessoryImage = @"dog1.jpg";
    }
    else if ([myAnnotation.title isEqualToString:@"Special Delivery"] | [myAnnotation.title isEqualToString:@"Sir Jimmy The Swift"])
    {
        accessoryImage = @"shoe.gif";
    }
    else if ([myAnnotation.title isEqualToString:@"Bandits in the Woods"] | [myAnnotation.title isEqualToString:@"HotDogg The Bounty Hunter"])
    {
        accessoryImage = @"hotdog.jpg";
    }
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:accessoryImage]];
    self.leftCalloutAccessoryView = imageView;
    self.enabled = YES;
    self.canShowCallout = YES;
    self.rightCalloutAccessoryView = [UIButton  buttonWithType:UIButtonTypeDetailDisclosure];
    
    return self;
    
    
}

@end
