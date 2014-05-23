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

- (IBAction)alignmentSegmented:(id)sender;
- (IBAction)pressedSave:(id)sender;
- (IBAction)pressedUpdateLocation:(id)sender;
- (IBAction)pressedBackOnSettings:(id)sender;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) id <AlignmentDelegate> delegate;
@property (strong, nonatomic) IBOutlet UISegmentedControl *alignmentOutlet;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UITextField *txtFldName;
@property (nonatomic) int alignment;

@end
