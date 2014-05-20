//
//  DetailViewController.m
//  MyriadMobileChallenge
//
//  Created by Jackie Scott on 5/6/14.
//  Copyright (c) 2014 Jilian Scott. All rights reserved.
//

#import "DetailViewController.h"
#import "JSAnnotationView.h"


@interface DetailViewController ()

@end

@implementation DetailViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
   //DetailViewController: setting labels based on tableViewCell click (Quest)
    _labelDescription.text = _holderdescription;
    _labelPoster.text = _holderPoster;
    _labelTitle.text = _holderTitle;
    [self.mapView setDelegate:self];
    
    //calculations for centering mapView based on Quest and Poster locations
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
    questAnnotation.title = _holderTitle;
    questAnnotation.subtitle = @"Complete this quest Here";
    questAnnotation.type = @"Quest";
    [self.mapView addAnnotation:questAnnotation];
    
    QuestsAnnotation *giverAnnotation = [[QuestsAnnotation alloc] initWithPosition:centerGiver];
    giverAnnotation.title = _holderPoster;
    giverAnnotation.subtitle = @"Quest Poster";
    giverAnnotation.type = @"Poster";
    [self.mapView addAnnotation:giverAnnotation];
    
  
    
    /*
     MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = .20f;
    span.longitudeDelta = .20f;
    region.center = center;
    region.span =span;
     Old methodology to set region
    */
   //[_mapView setRegion:region animated:YES];
    
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
            CLLocationCoordinate2DMake(_holderQuestLatitude, _holderQuestLongitude);
            NSLog(@"%f, %f", _holderQuestLatitude, _holderQuestLongitude);
            MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate
                                                           addressDictionary:nil];
            MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
            [mapItem setName:[NSString stringWithFormat:@"%@", _holderTitle]];
            // Pass the map item to the Maps app
            [mapItem openInMapsWithLaunchOptions:nil];
            
        }
        else if ([myAnnotation.type isEqualToString:@"Poster"])
        {
            CLLocationCoordinate2D coordinate =
            CLLocationCoordinate2DMake(_holderGiverLatitude, _holderGiverLongitude);
            NSLog(@"%f, %f", _holderGiverLatitude, _holderGiverLongitude);

            MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate
                                                           addressDictionary:nil];
            MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
            [mapItem setName:[NSString stringWithFormat:@"%@", _holderPoster]];
            // Pass the map item to the Maps app
            [mapItem openInMapsWithLaunchOptions:nil];
        }
    }
}



@end
