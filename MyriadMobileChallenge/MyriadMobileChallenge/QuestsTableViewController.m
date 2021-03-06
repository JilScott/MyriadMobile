//
//  QuestsTableViewController.m
//  MyriadMobileChallenge
//
//  Created by Jackie Scott on 5/6/14.
//  Copyright (c) 2014 Jilian Scott. All rights reserved.
//

#import "QuestsTableViewController.h"
#import "QuestCustomTableViewCell.h"
#import <Parse/Parse.h>

@interface QuestsTableViewController ()

@end

@implementation QuestsTableViewController
{
    NSMutableArray *arrayQuests;
    NSMutableArray *arrayFilteredQuests;
    PFUser *currentUser;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    arrayQuests = [Quest presetQuests];
    arrayFilteredQuests = [[NSMutableArray alloc] init];
    [self downloadQuests];
    currentUser = [PFUser currentUser];
    _alignmentQ = [[currentUser objectForKey:@"alignment"]intValue];
    _name = [currentUser objectForKey:@"name"];
    
    for (Quest *quest in arrayQuests)
    {
        if (_alignmentQ == 1)
        {
            arrayFilteredQuests = arrayQuests;
            break;
        }
        else  if (_alignmentQ == 2)
        {
            if (quest.alignment == 2)
            {
                [arrayFilteredQuests addObject:quest];
            }
        }
        else if(_alignmentQ == 0)
        {
            if (quest.alignment == 0)
            {
                [arrayFilteredQuests addObject:quest];
            }
        }
        else
        {
            _alignmentQ = 1;
            arrayFilteredQuests = arrayQuests;
        }
    }
    [self.tableView reloadData];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                                                   [UIFont fontWithName:@"Papyrus" size:28.0], NSFontAttributeName,nil];
    self.navigationController.navigationBar.topItem.title = @"Quests";
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(void)filterQuests
{
    arrayFilteredQuests = [[NSMutableArray alloc]init];
    if (_alignmentQ == 1)
    {
        arrayFilteredQuests = arrayQuests;
    }
    else
    {
        for (Quest *quest in arrayQuests)
        {
            if (_alignmentQ == 0)
            {
                if (quest.alignment == 0)
                {
                    [arrayFilteredQuests addObject:quest];
                }
            }
            else  if (_alignmentQ == 2)
            {
                if (quest.alignment == 2)
                {
                    [arrayFilteredQuests addObject:quest];
                }
            }
            else
            {
                arrayFilteredQuests = arrayQuests;
            }
        }
    }
    [self.tableView reloadData];

}

-(void)delegatePassAlignment:(int)alignment andName:(NSString *)name
{
    NSLog(@"%d", _alignmentQ);
    _alignmentQ = alignment;
    //0 = good, 1 = neutral, 2 = evil
    [self filterQuests];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayFilteredQuests count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuestCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[QuestCustomTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.accessoryView = [[ UIImageView alloc ]
                          initWithImage:[UIImage imageNamed:@"sword.png" ]];
    cell.labelQuestTitle.text = [NSString stringWithFormat:@"%@", ((Quest *)[arrayFilteredQuests objectAtIndex:indexPath.row]).questTitle];
    cell.labelQuestPoster.text = [NSString stringWithFormat:@"Posted by: %@", ((Quest *)[arrayFilteredQuests objectAtIndex:indexPath.row]).giver];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"questDetails"])
    {
        DetailViewController *dvc = [segue destinationViewController];
        dvc.selectedQuest = [arrayQuests objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    }
    else if ([segue.identifier isEqualToString:@"settings"])
    {
        SettingsViewController *svc = [segue destinationViewController];
        svc.delegate = self;
        svc.alignment = _alignmentQ;
        svc.name = _name;
    }
}

- (IBAction)pressedLogOut:(id)sender
{
    [PFUser logOut];
    currentUser = [PFUser currentUser];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)downloadQuests
{
    NSMutableArray *downloadedQuests = [[NSMutableArray alloc] init];
    PFQuery *query = [PFQuery queryWithClassName:@"Quests"];
    
    [query includeKey:@"questGiver"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *onlineQuests, NSError *error)
     {
         if (!error)
         {
             // The find succeeded.
             NSLog(@"Successfully retrieved %lu quests.", (unsigned long)onlineQuests.count);
             for (PFObject *quest in onlineQuests)
             {
                 Quest *downloadedQuest = [[Quest alloc] init];
                 downloadedQuest.questTitle = quest[@"name"];
                 downloadedQuest.alignment = [quest[@"alignment"]intValue];
                 downloadedQuest.description = quest[@"description"];
                 
                 PFGeoPoint *questGeoPoint = quest[@"location"];
                 downloadedQuest.questLatitude = questGeoPoint.latitude;
                 downloadedQuest.questLongitude = questGeoPoint.longitude;
                 
                 PFUser *giver = quest[@"questGiver"];
                 downloadedQuest.giver= giver[@"name"];
                 
                 PFGeoPoint *giverGeoPoint = giver[@"location"];
                 downloadedQuest.giverLatitude = giverGeoPoint.latitude;
                 downloadedQuest.giverLongitude = giverGeoPoint.longitude;
                 
                 [downloadedQuests addObject:downloadedQuest];
                 
                 NSLog(@"%@", quest.objectId);
             }
         }
         else
         {
             // Log details of the failure
             NSLog(@"Error: %@ %@", error, [error userInfo]);
         }
         [arrayQuests addObjectsFromArray:downloadedQuests];
         [self filterQuests];
     }];
}
@end
