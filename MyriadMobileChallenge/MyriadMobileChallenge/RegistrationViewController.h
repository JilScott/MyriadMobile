//
//  RegistrationViewController.h
//  MyriadMobileChallenge
//
//  Created by Jackie Scott on 5/21/14.
//  Copyright (c) 2014 Jilian Scott. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistrationViewController : UIViewController <UITextFieldDelegate>

- (IBAction)pressedAnywhereDismissKeyboard:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtFldUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtFldPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtFldHeroName;
- (IBAction)pressedSignUp:(id)sender;
- (IBAction)pressedCancel:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *alignmentSegment;
@property (weak, nonatomic) IBOutlet UILabel *labelRegistrationAlerts;
- (IBAction)pressedAlignment:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *alignmentView;






@end
