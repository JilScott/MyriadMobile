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
    
    
    //default for Remember Username set to OFF
    // _switcher.on = NO;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *usernameObject = [defaults objectForKey:@"logIn"];
    _txtFldUsername.text = usernameObject;
    
    
    
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

- (IBAction)pressedLogIn:(id)sender
{
    if (_switcher.on == YES)
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:_txtFldUsername.text forKey:@"logIn"];
        [defaults synchronize];
    }
    else
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
                 [self performSegueWithIdentifier:@"loggedIn" sender:self];
             }
             else
             {
                 NSLog(@"%@ %@", user, error);
                 _labelBegin.backgroundColor = [UIColor redColor];
                 _labelBegin.text = [NSString stringWithFormat:@"%@ %@", user, error];
             }
         }];
    }
}

- (IBAction)dismissKeyboard:(id)sender
{
    [text resignFirstResponder];
}

- (IBAction)pressedSwitch:(id)sender {
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    text = textField;
}

- (IBAction)pressedRegister:(id)sender
{
    //[self performSegueWithIdentifier:@"register" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"loggedIn"])
    {
        UINavigationController *navigationController = [segue destinationViewController];
        QuestsTableViewController *qvc = (QuestsTableViewController*)navigationController.topViewController;
        qvc.alignmentQ = 1;
        qvc.name = _txtFldUsername.text;
    }
    
}
@end
