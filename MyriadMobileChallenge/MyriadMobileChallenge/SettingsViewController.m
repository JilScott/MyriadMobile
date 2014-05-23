//
//  SettingsViewController.m
//  MyriadMobileChallenge
//
//  Created by Jackie Scott on 5/7/14.
//  Copyright (c) 2014 Jilian Scott. All rights reserved.
//

#import "SettingsViewController.h"
#import <Parse/Parse.h>

@interface SettingsViewController ()

@end

@implementation SettingsViewController
{
    PFUser *user;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    user = [PFUser currentUser];
    
    _txtFldName.text = user[@"name"];
    _alignmentOutlet.selectedSegmentIndex = [user[@"alignment"]intValue];
}

- (IBAction)alignmentSegmented:(id)sender
{
    NSLog(@"%d msg", _alignmentOutlet.selectedSegmentIndex);
    if (_alignmentOutlet.selectedSegmentIndex == 0)
    {
        _alignment = 0;
        NSLog(@"chose good");
        _alignmentOutlet.backgroundColor = [UIColor purpleColor];
        _backgroundImage.image = [UIImage imageNamed:@"unicorn.jpg"];
    }
    else if (_alignmentOutlet.selectedSegmentIndex == 1)
    {
        _alignment = 1;
        NSLog(@"chose neutral");
        _alignmentOutlet.backgroundColor = [UIColor blueColor];
        _backgroundImage.image = [UIImage imageNamed:@"hobbit.jpg"];
    }
    else if (_alignmentOutlet.selectedSegmentIndex == 2)
    {
        _alignment = 2;
        NSLog(@"chose evil");
        _alignmentOutlet.backgroundColor = [UIColor blackColor];
        _backgroundImage.image = [UIImage imageNamed:@"dragon1.jpg"];
    }
    else
    {
        _alignment = 3;
        NSLog(@"Error selecting alignment in Settings");
    }
    
}
- (IBAction)pressedBackOnSettings:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)pressedSave:(id)sender
{
    [_delegate delegatePassAlignment:_alignmentOutlet.selectedSegmentIndex andName:_txtFldName.text];
    
    user = [PFUser currentUser];
    user[@"name"] =_txtFldName.text;
    user[@"alignment"] = [NSNumber numberWithInteger:_alignmentOutlet.selectedSegmentIndex];
    [user saveInBackground];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)pressedUpdateLocation:(id)sender
{
    //configure to update GeoLocation via Parse
}
@end
