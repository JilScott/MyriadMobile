//
//  SettingsViewController.h
//  MyriadMobileChallenge
//
//  Created by Jackie Scott on 5/7/14.
//  Copyright (c) 2014 Jilian Scott. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AlignmentDelegate
-(void)delegatePassAlignment:(int)alignment andName: (NSString *)name;
@end
@interface SettingsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *txtFldName;
- (IBAction)alignmentSegmented:(id)sender;
@property (strong, nonatomic) IBOutlet UISegmentedControl *alignmentOutlet;
@property (nonatomic) int alignment;
@property (strong, nonatomic) id <AlignmentDelegate> delegate;
- (IBAction)pressedBackOnSettings:(id)sender;
@property (strong, nonatomic) NSString *name;
- (IBAction)pressedSave:(id)sender;
- (IBAction)pressedUpdateLocation:(id)sender;

@end
