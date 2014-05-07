//
//  ViewController.m
//  MyriadMobileChallenge
//
//  Created by Jackie Scott on 5/6/14.
//  Copyright (c) 2014 Jilian Scott. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSString *username;
    NSString *password;
    UITextField *text;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    username = @"Lancelot";
    password = @"arthurDoesntKnow";

    
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{    
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)pressedLogIn:(id)sender
{
    
       if ([_txtFldUsername.text isEqualToString: username] && [_txtFldPasword.text isEqualToString:password])
    {
        _labelBegin.text = @"Log In To Begin Quests!";
        [self performSegueWithIdentifier:@"loggedIn" sender:self];
    }
    else
    {
        _labelBegin.text = @"Incorrect Username or Password";
        _labelBegin.backgroundColor = [UIColor redColor];
    }
}

- (IBAction)dismissKeyboard:(id)sender
{
    [text resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    text = textField;
}


@end
