//
//  ViewController.m
//  MyriadMobileChallenge
//
//  Created by Jackie Scott on 5/6/14.
//  Copyright (c) 2014 Jilian Scott. All rights reserved.
//

#import "ViewController.h"
#import <FacebookSDK/FacebookSDK.h>


@interface ViewController ()

@end

@implementation ViewController
{
    UITextField *text;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _txtFldUsername.text = [defaults objectForKey:@"logIn"];
}

-(void)viewDidAppear:(BOOL)animated
{
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser)
    {
        [self performSegueWithIdentifier:@"loggedIn" sender:self];
    }
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)dismissKeyboard:(id)sender
{
    [text resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    text = textField;
}

- (IBAction)pressedLogIn:(id)sender
{
    if (_switcher.on == YES)//save username
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:_txtFldUsername.text forKey:@"logIn"];
        [defaults synchronize];
    }
    else //dont save username
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"" forKey:@"logIn"];
        [defaults synchronize];
    }
    
    if ([_txtFldUsername.text isEqualToString:@""] | [_txtFldPasword.text isEqualToString:@""])
    {
        _labelBegin.text = @"Incorrect Username Or Password";
        _labelBegin.backgroundColor = [UIColor redColor];
    }
    else
    {
        [PFUser logInWithUsernameInBackground:_txtFldUsername.text password:_txtFldPasword.text
                                        block:^(PFUser *user, NSError *error)
         {
             if (user)
             {
                 _txtFldPasword.text =@"";
                 _labelBegin.text = @"Begin Your Quests!";
                 _labelBegin.backgroundColor = [UIColor whiteColor];
                 [self performSegueWithIdentifier:@"loggedIn" sender:self];
             }
             else
             {
                 NSLog(@"%@ %@", user, error);
                 UIAlertView  *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error!"
                                                                       message:[NSString stringWithFormat:@"%@ %@", user, error]
                                                                      delegate:self
                                                             cancelButtonTitle:@"Ok"
                                                             otherButtonTitles:nil];
                 [errorAlert show];
             }
         }];
    }
}
/*
- (IBAction)facebookButton:(id)sender //finish or remove
{
    
    [PFFacebookUtils logInWithPermissions:nil block:^(PFUser *user, NSError *error)
    {
        if (!user)
        {
            UIAlertView  *errorAlert = [[UIAlertView alloc] initWithTitle:@"Facebook Registration Error"
                                                                  message:[NSString stringWithFormat:@"Error logging in with facebook:%@. Try Again or Sign Up", error]
                                                                 delegate:self
                                                        cancelButtonTitle:@"Ok"
                                                        otherButtonTitles:nil];
            [errorAlert show];
            NSLog(@"Uh oh. The user cancelled the Facebook login.");
        }
        else if (user.isNew)
        {
            user[@"alignment"] = [NSNumber numberWithInteger:1];
            [user saveInBackground];
            [self performSegueWithIdentifier:@"loggedIn" sender:self];
//currently unassigned hero name if user logs in with facebook
            NSLog(@"User signed up and logged in through Facebook!");
        }
        else
        {
            NSLog(@"User logged in through Facebook!");
            [self performSegueWithIdentifier:@"loggedIn" sender:self];
        }
    }];
}
*/
@end
