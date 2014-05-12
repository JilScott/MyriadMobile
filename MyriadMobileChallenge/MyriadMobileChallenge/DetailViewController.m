//
//  DetailViewController.m
//  MyriadMobileChallenge
//
//  Created by Jackie Scott on 5/6/14.
//  Copyright (c) 2014 Jilian Scott. All rights reserved.
//

#import "DetailViewController.h"


@interface DetailViewController ()

@end

@implementation DetailViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
   
    _labelDescription.text = _holderdescription;
    _labelPoster.text = _holderPoster;
    _labelTitle.text = _holderTitle;


    MKCoordinateRegion region;
    
    float centerLatitude = (_holderGiverLatitude+_holderQuestLatitude)/2;
float centerLongitude = (_holderGiverLongitude + _holderQuestLongitude)/2;
        CLLocationCoordinate2D center;
    center.latitude = centerLatitude;
    center.longitude = centerLongitude;
    
    CLLocationCoordinate2D centerQuest;
    centerQuest.latitude = _holderQuestLatitude;
    centerQuest.longitude = _holderQuestLongitude;
    CLLocationCoordinate2D centerGiver;
    centerGiver.latitude = _holderGiverLatitude;
    centerGiver.longitude = _holderGiverLongitude;
    
    QuestsAnnotation *questAnnotation = [[QuestsAnnotation alloc] initWithPosition:centerQuest];
    questAnnotation.title = _holderTitle;
questAnnotation.subtitle = @"Complete this quest Here";
    QuestsAnnotation *giverAnnotation = [[QuestsAnnotation alloc] initWithPosition:centerGiver];
    giverAnnotation.title = _holderPoster;
    giverAnnotation.subtitle = @"Return to this Quest Giver after completion";
    [self.mapView addAnnotation:questAnnotation];
    [self.mapView addAnnotation:giverAnnotation];

    MKCoordinateSpan span;
    span.latitudeDelta = .20f;
    span.longitudeDelta = .20f;
    region.center = center;
    region.span =span;
    
    [_mapView setRegion:region animated:YES];
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)pressedBack:(id)sender {
}
@end
