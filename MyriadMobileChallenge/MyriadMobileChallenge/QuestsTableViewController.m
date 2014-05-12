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
    NSMutableArray *goodQuests;
    NSMutableArray *neutralQuests;
    NSMutableArray *evilQuests;
    Quest *questObject;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _alignmentQ = 1;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *alignment = [defaults objectForKey:@"alignment"];
    _alignmentQ = alignment.intValue;
    
    goodQuests = [[NSMutableArray alloc]init];
    neutralQuests = [[NSMutableArray alloc]init];
    evilQuests = [[NSMutableArray alloc]init];
    
    questObject = [[Quest alloc] init];
    questObject.questTitle = @"Bandits in the Woods";
    questObject.alignment = @"Good";
    questObject.description = @"The famed bounty hunter HotDog has requested the aid of a hero in ridding the woods of terrifying bandits who have thus far eluded his capture, as he is actually a dog, and cannot actually grab things more than 6 feet off the ground. ";
    questObject.giver = @"HotDogg The Bounty Hunter";
    questObject.giverLatitude = 46.8541979;
    questObject.giverLongitude = -96.8285138;
    questObject.questLatitude = 46.908588;
    questObject.questLongitude = -96.808991;
    [goodQuests addObject:questObject];
    
    questObject = [[Quest alloc] init];
    questObject.questTitle = @"Special Delivery";
    questObject.alignment = @"Neutral";
    questObject.description = @"Sir Jimmy was once the fastest man in the kingdom, brave as any soldier and wise as a king. Unfortunately, age catches us all in the end, and he has requested that I, his personal scribe, find a hero to deliver a package of particular importance--and protect it with their life.";
    questObject.giver = @"Sir Jimmy The Swift";
    questObject.giverLatitude = 46.8739748;
    questObject.giverLongitude = -96.806112;
    questObject.questLatitude = 46.8657639;
    questObject.questLongitude = -96.7363173;
    [neutralQuests addObject:questObject];
    
    
    questObject = [[Quest alloc] init];
    questObject.questTitle = @"Filthy Mongrel";
    questObject.alignment = @"Evil";
    questObject.description = @"That strange dog that everyone is treating like a bounty-hunter must go. By the order of Prince Jack, that smelly, disease ridden mongrel must be removed from our streets by any means necessary. He is disrupting the lives of ordinary citizens, and it's just really weird. Make it gone.";
    questObject.giver = @"Prince Jack, The Iron Horse";
    questObject.giverLatitude = 46.8739748;
    questObject.giverLongitude = -96.806112;
    questObject.questLatitude = 46.892386;
    questObject.questLongitude = -96.799669;
    [evilQuests addObject:questObject];
    
    
    if (_alignmentQ == 0)
    {
        arrayQuests = [[NSMutableArray alloc] initWithArray:goodQuests];
        
    }
    else if (_alignmentQ == 1)
    {
        arrayQuests = [[NSMutableArray alloc]initWithArray:goodQuests];
        [arrayQuests addObjectsFromArray:evilQuests];
        [arrayQuests addObjectsFromArray:neutralQuests];
    }
    else if (_alignmentQ == 2)
    {
        arrayQuests = [[NSMutableArray alloc]initWithArray:evilQuests];
    }
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(void)delegatePass:(int)alignment
{
    _alignmentQ = alignment;
    NSLog(@"%d", _alignmentQ);
    //0 = good, 1 = neutral, 2 = evil
    if (_alignmentQ == 0)
    {
        arrayQuests = [[NSMutableArray alloc] initWithArray:goodQuests];
        
    }
    else if (_alignmentQ == 1)
    {
        arrayQuests = [[NSMutableArray alloc]initWithArray:goodQuests];
        [arrayQuests addObjectsFromArray:evilQuests];
        [arrayQuests addObjectsFromArray:neutralQuests];
    }
    else if (_alignmentQ == 2)
    {
        arrayQuests = [[NSMutableArray alloc]initWithArray:evilQuests];
    }
    [self.tableView reloadData];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSString stringWithFormat:@"%d", _alignmentQ] forKey:@"alignment"];
    [defaults synchronize];
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
        dvc.holderGiverLatitude = ((Quest *)[arrayQuests objectAtIndex:self.tableView.indexPathForSelectedRow.row]).giverLatitude;
         dvc.holderGiverLongitude = ((Quest *)[arrayQuests objectAtIndex:self.tableView.indexPathForSelectedRow.row]).giverLongitude;
         dvc.holderQuestLatitude = ((Quest *)[arrayQuests objectAtIndex:self.tableView.indexPathForSelectedRow.row]).questLatitude;
         dvc.holderQuestLongitude = ((Quest *)[arrayQuests objectAtIndex:self.tableView.indexPathForSelectedRow.row]).questLongitude;
    }
    else if ([segue.identifier isEqualToString:@"settings"])
    {
        SettingsViewController *svc = [segue destinationViewController];
        svc.delegate = self;
        svc.alignment = _alignmentQ;
    }
}

@end
