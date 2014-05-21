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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)pressedAnywhereDismissKeyboard:(id)sender
{
    [text resignFirstResponder];
}

- (IBAction)pressedSignUp:(id)sender
{
    if ([_txtFldUsername.text isEqualToString:@""])
    {
        _labelRegistrationAlerts.text = @"Must Complete All Fields";
    }
    else if ([_txtFldPassword.text isEqualToString:@""])
    {
        _labelRegistrationAlerts.text = @"Must Complete All Fields";
    }
    else if ([_txtFldHeroName.text isEqualToString:@""])
    {
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
                 [self performSegueWithIdentifier:@"registered" sender:self];
            }
            else
            {
                NSString *errorString = [error userInfo][@"error"];
                NSLog(@"%@", errorString);
                _labelRegistrationAlerts.text = [NSString stringWithFormat:@"Error: %@", errorString];
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
             qvc.name = _txtFldHeroName.text;
    }
}
@end
