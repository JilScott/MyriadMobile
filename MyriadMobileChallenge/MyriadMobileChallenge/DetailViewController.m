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
    
    _labelDescription.text = _holderdescription;
    _labelPoster.text = _holderPoster;
    _labelTitle.text = _holderTitle;
    
    [self.mapView setDelegate:self];
    
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
    questAnnotation.type = @"Quest";
    [self.mapView addAnnotation:questAnnotation];
    
    QuestsAnnotation *giverAnnotation = [[QuestsAnnotation alloc] initWithPosition:centerGiver];
    giverAnnotation.title = _holderPoster;
    giverAnnotation.subtitle = @"Quest Poster";
    giverAnnotation.type = @"Poster";
    [self.mapView addAnnotation:giverAnnotation];
    
    MKCoordinateSpan span;
    span.latitudeDelta = .20f;
    span.longitudeDelta = .20f;
    region.center = center;
    region.span =span;
    
    [_mapView setRegion:region animated:YES];
    
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
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end
