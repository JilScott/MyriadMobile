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
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *alignment = [defaults objectForKey:@"alignment"];
    
    arrayQuests = [Quest presetQuests];
    arrayFilteredQuests = [[NSMutableArray alloc] init];
    
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
        else if (alignment)
        {
            _alignmentQ = alignment.intValue;
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
    if (_name)
    {
        self.navigationController.navigationBar.topItem.title = [NSString stringWithFormat:@"Your Quests, %@", _name];
    }
    else
    {
        self.navigationController.navigationBar.topItem.title = [NSString stringWithFormat:@"Welcome"];
    }
    
    //filtering complete array of quests based on alignment (0=good, 1=neutral, 2=evil)
    /*
     arrayFilteredQuests = [[NSMutableArray alloc] init];
     
     for (Quest *quest in arrayQuests)
     {
     if (_alignmentQ == 0)
     {
     if (quest.alignment == 0)
     {
     [arrayFilteredQuests addObject:quest];
     }
     }
     else  if (_alignmentQ == 1)
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
     else
     {
     arrayFilteredQuests = arrayQuests;
     }
     }
     
     */
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(void)delegatePassAlignment:(int)alignment andName:(NSString *)name
{
    _name = name;
    NSLog(@"%d %@", _alignmentQ, _name);
    self.navigationController.navigationBar.topItem.title = [NSString stringWithFormat:@"Your Quests, %@", _name];
    _alignmentQ = alignment;
    //0 = good, 1 = neutral, 2 = evil
    arrayFilteredQuests = [[NSMutableArray alloc]init];
    
    for (Quest *quest in arrayQuests)
    {
        if (_alignmentQ == 0)
        {
            if (quest.alignment == 0)
            {
                [arrayFilteredQuests addObject:quest];
            }
        }
        else  if (_alignmentQ == 1)
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
        else
        {
            arrayFilteredQuests = arrayQuests;
        }
    }
    [self.tableView reloadData];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSString stringWithFormat:@"%d", _alignmentQ] forKey:@"alignment"];
    [defaults setObject:_name forKey:@"name"];
    [defaults synchronize];
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
@end
