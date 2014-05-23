//
//  QuestsTableViewController.h
//  MyriadMobileChallenge
//
//  Created by Jackie Scott on 5/6/14.
//  Copyright (c) 2014 Jilian Scott. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Quest.h"
#import "DetailViewController.h"
#import "SettingsViewController.h"

@interface QuestsTableViewController : UITableViewController <AlignmentDelegate>

- (IBAction)pressedLogOut:(id)sender;
@property (nonatomic) int alignmentQ;
@property (strong, nonatomic) NSString *name;

@end
