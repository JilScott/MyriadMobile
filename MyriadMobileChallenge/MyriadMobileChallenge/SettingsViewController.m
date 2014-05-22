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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)alignmentSegmented:(id)sender
{
    NSLog(@"%d msg", _alignmentOutlet.selectedSegmentIndex);
    if (_alignmentOutlet.selectedSegmentIndex == 0)
    {
        _alignment = 0;
        NSLog(@"chose good");
        _alignmentOutlet.backgroundColor = [UIColor redColor];

    }
    else if (_alignmentOutlet.selectedSegmentIndex == 1)
    {
        _alignment = 1;
        NSLog(@"chose neutral");
        _alignmentOutlet.backgroundColor = [UIColor blueColor];

    }
    else if (_alignmentOutlet.selectedSegmentIndex == 2)
    {
        _alignment = 2;
        NSLog(@"chose evil");
        _alignmentOutlet.backgroundColor = [UIColor blackColor];

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
