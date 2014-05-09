//
//  ViewController.h
//  MyriadMobileChallenge
//
//  Created by Jackie Scott on 5/6/14.
//  Copyright (c) 2014 Jilian Scott. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestsTableViewController.h"

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtFldUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtFldPasword;
- (IBAction)pressedLogIn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *labelBegin;
@property (weak, nonatomic) IBOutlet UIButton *buttonLogIn;
- (IBAction)dismissKeyboard:(id)sender;
- (IBAction)pressedSwitch:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *switcher;








@end
