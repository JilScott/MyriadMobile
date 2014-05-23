//
//  DetailViewController.m
//  MyriadMobileChallenge
//
//  Created by Jackie Scott on 5/6/14.
//  Copyright (c) 2014 Jilian Scott. All rights reserved.
//

#import "DetailViewController.h"
#import "JSAnnotationView.h"
#import <Parse/Parse.h>


@interface DetailViewController ()

@end

@implementation DetailViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
   //DetailViewController: setting labels based on tableViewCell click (Quest)
    _labelDescription.text = _selectedQuest.description;
    _labelPoster.text = _selectedQuest.giver;
    _labelTitle.text = _selectedQuest.questTitle;
    [self.mapView setDelegate:self];
    
    //calculations for centering mapView based on Quest and Poster locations
    float centerLatitude = (_selectedQuest.giverLatitude +_selectedQuest.questLatitude)/2;
    float centerLongitude = (_selectedQuest.giverLongitude + _selectedQuest.questLongitude)/2;
    CLLocationCoordinate2D center;
    center.latitude = centerLatitude;
    center.longitude = centerLongitude;
    
    CLLocationCoordinate2D centerQuest;
    centerQuest.latitude = _selectedQuest.questLatitude;
    centerQuest.longitude = _selectedQuest.questLongitude;
    
    CLLocationCoordinate2D centerGiver;
    centerGiver.latitude = _selectedQuest.giverLatitude;
    centerGiver.longitude = _selectedQuest.giverLongitude;
    
    CLLocationCoordinate2D user_location;
    user_location.latitude = _mapView.userLocation.location.coordinate.latitude;
    user_location.longitude = _mapView.userLocation.location.coordinate.longitude;
    //user location currently unused
    
    
    // Make map points
    MKMapPoint questPoint = MKMapPointForCoordinate(centerQuest);
    MKMapPoint giverPoint = MKMapPointForCoordinate(centerGiver);
    // Make map rects with 0 size
    MKMapRect userRect = MKMapRectMake(questPoint.x, questPoint.y, 0, 0);
    MKMapRect annotationRect = MKMapRectMake(giverPoint.x, giverPoint.y, 0, 0);
    // Make union of those two rects
    MKMapRect unionRect = MKMapRectUnion(userRect, annotationRect);
    // You have the smallest possible rect containing both locations
    MKMapRect unionRectThatFits = [_mapView mapRectThatFits:unionRect];
    double inset = -unionRectThatFits.size.width * 0.2;
    [_mapView setVisibleMapRect:MKMapRectInset(unionRectThatFits, inset, inset) animated:YES];
    [_mapView setCenterCoordinate:center animated:YES];
    //mapView centered based on actual size of mapView (rather than assuming full ViewController size)
    
    QuestsAnnotation *questAnnotation = [[QuestsAnnotation alloc] initWithPosition:centerQuest];
    questAnnotation.title = _selectedQuest.questTitle;
    questAnnotation.subtitle = @"Complete this quest Here";
    questAnnotation.type = @"Quest";
    [self.mapView addAnnotation:questAnnotation];
    
    QuestsAnnotation *giverAnnotation = [[QuestsAnnotation alloc] initWithPosition:centerGiver];
    giverAnnotation.title = _selectedQuest.giver;
    giverAnnotation.subtitle = @"Quest Poster";
    giverAnnotation.type = @"Poster";
    [self.mapView addAnnotation:giverAnnotation];
}

-(void)viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:@"Papyrus" size:28.0], NSFontAttributeName,nil];
    self.navigationController.navigationBar.topItem.title = @"Details";
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    JSAnnotationView *view = (JSAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:@"pin"];
    if (view == nil)
    {
        view =  [[JSAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pin"];
    }
    return view;
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    QuestsAnnotation *myAnnotation = (QuestsAnnotation *)view.annotation;

    Class mapItemClass = [MKMapItem class];
    if (mapItemClass && [mapItemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)])
    {
        // Differentiate quest/objective and location to  pass to the Maps app
        if ([myAnnotation.type isEqualToString:@"Quest"])
        {
            CLLocationCoordinate2D coordinate =
            CLLocationCoordinate2DMake(_selectedQuest.questLatitude, _selectedQuest.questLongitude);
            NSLog(@"%f, %f",_selectedQuest.questLatitude, _selectedQuest.questLongitude);
            MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate
                                                           addressDictionary:nil];
            MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
            [mapItem setName:[NSString stringWithFormat:@"%@", _selectedQuest.questTitle]];
            // Pass the map item to the Maps app
            [mapItem openInMapsWithLaunchOptions:nil];
            
        }
        else if ([myAnnotation.type isEqualToString:@"Poster"])
        {
            CLLocationCoordinate2D coordinate =
            CLLocationCoordinate2DMake(_selectedQuest.giverLatitude, _selectedQuest.giverLongitude);
            NSLog(@"%f, %f", _selectedQuest.giverLatitude, _selectedQuest.giverLongitude);

            MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate
                                                           addressDictionary:nil];
            MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
            [mapItem setName:[NSString stringWithFormat:@"%@",_selectedQuest.giver]];
            // Pass the map item to the Maps app
            [mapItem openInMapsWithLaunchOptions:nil];
        }
    }
}

- (IBAction)pressedAcceptQuest:(id)sender //implement or remove
{
    [_acceptQuestLabel setTitle:@"Accepted Quest" forState:UIControlStateNormal];
    [_acceptQuestLabel setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
}
@end
