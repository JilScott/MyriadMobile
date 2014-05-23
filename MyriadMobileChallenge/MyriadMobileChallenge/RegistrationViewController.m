//
//  RegistrationViewController.m
//  MyriadMobileChallenge
//
//  Created by Jackie Scott on 5/21/14.
//  Copyright (c) 2014 Jilian Scott. All rights reserved.
//

#import "RegistrationViewController.h"
#import "QuestsTableViewController.h"
#import <Parse/Parse.h>

@interface RegistrationViewController ()

@end

@implementation RegistrationViewController
{
    UITextField *text;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)pressedAnywhereDismissKeyboard:(id)sender
{
    [_txtFldUsername resignFirstResponder];
    [_txtFldPassword resignFirstResponder];
    [_txtFldHeroName resignFirstResponder];

    NSLog(@"dismiss button clickable");
}

- (IBAction)pressedSignUp:(id)sender
{
    UIAlertView * alert;
    if ([_txtFldUsername.text isEqualToString:@""])
    {
        alert =[[UIAlertView alloc ] initWithTitle:@"Required Fields Incomplete"
                                           message:@"Must Enter A Username"
                                          delegate:self
                                 cancelButtonTitle:@"Ok"
                                 otherButtonTitles: nil];
        [alert show];
        
        _labelRegistrationAlerts.text = @"Must Enter a Username";
    }
    else if ([_txtFldPassword.text isEqualToString:@""])
    {
        alert =[[UIAlertView alloc ] initWithTitle:@"Required Fields Incomplete"
                                           message:@"Must Enter A Password"
                                          delegate:self
                                 cancelButtonTitle:@"Ok"
                                 otherButtonTitles: nil];
        [alert show];
        _labelRegistrationAlerts.text = @"Must Complete All Fields";
    }
    else if ([_txtFldHeroName.text isEqualToString:@""])
    {
        alert =[[UIAlertView alloc ] initWithTitle:@"Required Fields Incomplete"
                                           message:@"Must Enter A Hero Name"
                                          delegate:self
                                 cancelButtonTitle:@"Ok"
                                 otherButtonTitles: nil];
        [alert show];
        _labelRegistrationAlerts.text = @"Must Complete All Fields";
    }
    else
    {
        PFUser *user = [PFUser user]; //creating blank dictionary for user
        user.username = _txtFldUsername.text; //default settings to save
        user.password = _txtFldPassword.text;
        user[@"name"] = _txtFldHeroName.text;
        user[@"alignment"] = [NSNumber numberWithInteger:_alignmentSegment.selectedSegmentIndex];
        
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error)
            {
                _labelRegistrationAlerts.text = @"";
                _txtFldUsername.text = @"";
                _txtFldPassword.text = @"";
                _txtFldHeroName.text = @"";
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            else
            {
                NSString *errorString = [error userInfo][@"error"];
                NSLog(@"%@", errorString);
                UIAlertView  *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error!"
                                                                      message:[NSString stringWithFormat:@"%@", errorString]
                                                                     delegate:self
                                                            cancelButtonTitle:@"Ok"
                                                            otherButtonTitles:nil];
                [errorAlert show];
                // Show the errorString and let the user try again.
            }
        }];
    }
}

- (IBAction)pressedCancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"registered"])
    {
        UINavigationController *navigationController = [segue destinationViewController];
        QuestsTableViewController *qvc = (QuestsTableViewController*)navigationController.topViewController;
        qvc.alignmentQ = _alignmentSegment.selectedSegmentIndex;
        //qvc.name = _txtFldHeroName.text;
    }
}
- (IBAction)pressedAlignment:(id)sender
{
    if (_alignmentSegment.selectedSegmentIndex == 1)
    {
        _alignmentView.image = [UIImage imageNamed:@"neutral.jpg"];
        _alignmentSegment.backgroundColor = [UIColor blueColor];
    }
    else if (_alignmentSegment.selectedSegmentIndex == 0)
    {
        _alignmentView.image = [UIImage imageNamed:@"unicornKill.jpg"];
        _alignmentSegment.backgroundColor = [UIColor redColor];
    }
    else if (_alignmentSegment.selectedSegmentIndex == 2)
    {
        _alignmentView.image = [UIImage imageNamed:@"evilDragon.jpg"];
        _alignmentSegment.backgroundColor = [UIColor blackColor];
    }
}
@end
