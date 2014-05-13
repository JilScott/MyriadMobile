//
//  DetailViewController.h
//  MyriadMobileChallenge
//
//  Created by Jackie Scott on 5/6/14.
//  Copyright (c) 2014 Jilian Scott. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestsTableViewController.h"
#import "Quest.h"
#import <MapKit/MapKit.h>
#import "QuestsAnnotation.h"

@interface DetailViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (strong, nonatomic) NSString *holderTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelPoster;
@property (strong, nonatomic) NSString *holderPoster;
@property (weak, nonatomic) IBOutlet UILabel *labelDescription;
@property (strong, nonatomic) NSString *holderdescription;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic) float holderQuestLatitude;
@property (nonatomic) float holderQuestLongitude;
@property (nonatomic) float holderGiverLatitude;
@property (nonatomic) float holderGiverLongitude;









@end
