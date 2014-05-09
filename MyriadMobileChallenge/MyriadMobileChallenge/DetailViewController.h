//
//  DetailViewController.h
//  MyriadMobileChallenge
//
//  Created by Jackie Scott on 5/6/14.
//  Copyright (c) 2014 Jilian Scott. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestsTableViewController.h"
#import "Quest.h"


@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (strong, nonatomic) NSString *holderTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelPoster;
@property (strong, nonatomic) NSString *holderPoster;
@property (weak, nonatomic) IBOutlet UILabel *labelDescription;
@property (strong, nonatomic) NSString *holderdescription;
- (IBAction)pressedBack:(id)sender;







@end
