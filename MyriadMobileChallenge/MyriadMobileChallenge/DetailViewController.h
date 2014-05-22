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
@property (weak, nonatomic) IBOutlet UILabel *labelPoster;
@property (weak, nonatomic) IBOutlet UILabel *labelDescription;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) Quest *selectedQuest;

- (IBAction)pressedAcceptQuest:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *acceptQuestLabel;







@end
