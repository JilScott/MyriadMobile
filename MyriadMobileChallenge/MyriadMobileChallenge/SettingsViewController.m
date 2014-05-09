//
//  SettingsViewController.m
//  MyriadMobileChallenge
//
//  Created by Jackie Scott on 5/7/14.
//  Copyright (c) 2014 Jilian Scott. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    [_alignmentOutlet setTitle:@"Good" forSegmentAtIndex:0];
    [_alignmentOutlet setTitle:@"Neutral" forSegmentAtIndex:1];
    [_alignmentOutlet setTitle:@"Evil" forSegmentAtIndex:2];
   
   //_alignmentOutlet.selectedSegmentIndex = 1;
    
   
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *alignment = [defaults objectForKey:@"alignment"];
    //_alignment = alignment.intValue;
     _alignmentOutlet.selectedSegmentIndex = alignment.intValue;
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
    }
    else if (_alignmentOutlet.selectedSegmentIndex == 1)
    {
        _alignment = 1;
        NSLog(@"chose neutral");
    }
    else if (_alignmentOutlet.selectedSegmentIndex == 2)
    {
        _alignment = 2;
        NSLog(@"chose evil");
    }
    else
    {
        _alignment = 3;
    }

}
- (IBAction)pressedBackOnSettings:(id)sender
{
    if (_alignmentOutlet.selectedSegmentIndex == 0)
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"0" forKey:@"alignment"];
        [defaults synchronize];
        NSLog(@"saved good");

    }
    else if (_alignmentOutlet.selectedSegmentIndex == 1)
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"1" forKey:@"alignment"];
        [defaults synchronize];
        NSLog(@"saved neutral");
    }
    else if (_alignmentOutlet.selectedSegmentIndex == 2)
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"2" forKey:@"alignment"];
        [defaults synchronize];
        NSLog(@"saved evil");
    }
        [_delegate delegatePass:_alignment];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end