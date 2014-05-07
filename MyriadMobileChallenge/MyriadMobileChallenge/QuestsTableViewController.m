//
//  QuestsTableViewController.m
//  MyriadMobileChallenge
//
//  Created by Jackie Scott on 5/6/14.
//  Copyright (c) 2014 Jilian Scott. All rights reserved.
//

#import "QuestsTableViewController.h"

@interface QuestsTableViewController ()

@end

@implementation QuestsTableViewController
{
    NSMutableArray *arrayQuests;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    arrayQuests = [[NSMutableArray alloc] init];
    Quest *questObject = [[Quest alloc] init];
    questObject.questTitle = @"Bandits in the Woods";
    questObject.alignment = @"Good";
    questObject.description = @"The famed bounty hunter HotDog has requested the aid of a hero in ridding the woods of terrifying bandits who have thus far eluded his capture, as he is actually a dog, and cannot actually grab things more than 6 feet off the ground. ";
    questObject.giver = @"HotDogg The Bounty Hunter";
    [arrayQuests addObject:questObject];
    
    questObject = [[Quest alloc] init];
    questObject.questTitle = @"Special Delivery";
    questObject.alignment = @"Neutral";
    questObject.description = @"Sir Jimmy was once the fastest man in the kingdom, brave as any soldier and wise as a king. Unfortunately, age catches us all in the end, and he has requested that I, his personal scribe, find a hero to deliver a package of particular importance--and protect it with their life.";
    questObject.giver = @"Sir Jimmy The Swift";
    [arrayQuests addObject:questObject];
    
    questObject = [[Quest alloc] init];
    questObject.questTitle = @"Filthy Mongrel";
    questObject.alignment = @"Evil";
    questObject.description = @"That strange dog that everyone is treating like a bounty-hunter must go. By the order of Prince Jack, that smelly, disease ridden mongrel must be removed from our streets by any means necessary. He is disrupting the lives of ordinary citizens, and it's just really weird. Make it gone.";
    questObject.giver = @"Prince Jack, The Iron Horse";
    [arrayQuests addObject:questObject];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayQuests count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@", ((Quest *)[arrayQuests objectAtIndex:indexPath.row]).questTitle];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", ((Quest *)[arrayQuests objectAtIndex:indexPath.row]).alignment];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"questDetails"])
         {
             DetailViewController *dvc = [segue destinationViewController];
             dvc.holderTitle = ((Quest *)[arrayQuests objectAtIndex:self.tableView.indexPathForSelectedRow.row]).questTitle;
             dvc.holderPoster = ((Quest *)[arrayQuests objectAtIndex:self.tableView.indexPathForSelectedRow.row]).giver;
             dvc.holderdescription = ((Quest *)[arrayQuests objectAtIndex:self.tableView.indexPathForSelectedRow.row]).description;
         }
         }
         
         
         @end
