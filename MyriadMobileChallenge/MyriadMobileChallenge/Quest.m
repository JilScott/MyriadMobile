//
//  Quest.m
//  MyriadMobileChallenge
//
//  Created by Jackie Scott on 5/6/14.
//  Copyright (c) 2014 Jilian Scott. All rights reserved.
//

#import "Quest.h"
#import <Parse/Parse.h>

@implementation Quest

+(NSMutableArray*)presetQuests
{
    NSMutableArray *arrayQuests = [[NSMutableArray alloc]init];
    
    Quest *questObject = [[Quest alloc] init];
    questObject.questTitle = @"Bandits in the Woods";
    questObject.alignment = 0; //Good
    questObject.description = @"The famed bounty hunter HotDog has requested the aid of a hero in ridding the woods of terrifying bandits who have thus far eluded his capture, as he is actually a dog, and cannot actually grab things more than 6 feet off the ground. ";
    questObject.giver = @"HotDogg The Bounty Hunter";
    questObject.giverLatitude = 46.8541979;
    questObject.giverLongitude = -96.8285138;
    questObject.questLatitude = 46.908588;
    questObject.questLongitude = -96.808991;
    [arrayQuests addObject:questObject];
    
    questObject = [[Quest alloc] init];
    questObject.questTitle = @"Special Delivery";
    questObject.alignment = 1; //Neutral
    questObject.description = @"Sir Jimmy was once the fastest man in the kingdom, brave as any soldier and wise as a king. Unfortunately, age catches us all in the end, and he has requested that I, his personal scribe, find a hero to deliver a package of particular importance--and protect it with their life.";
    questObject.giver = @"Sir Jimmy The Swift";
    questObject.giverLatitude = 46.8739748;
    questObject.giverLongitude = -96.806112;
    questObject.questLatitude = 46.8657639;
    questObject.questLongitude = -96.7363173;
    [arrayQuests addObject:questObject];
    
    
    questObject = [[Quest alloc] init];
    questObject.questTitle = @"Filthy Mongrel";
    questObject.alignment = 2; //Evil
    questObject.description = @"That strange dog that everyone is treating like a bounty-hunter must go. By the order of Prince Jack, that smelly, disease ridden mongrel must be removed from our streets by any means necessary. He is disrupting the lives of ordinary citizens, and it's just really weird. Make it gone.";
    questObject.giver = @"Prince Jack, The Iron Horse";
    questObject.giverLatitude = 46.8739748;
    questObject.giverLongitude = -96.806112;
    questObject.questLatitude = 46.892386;
    questObject.questLongitude = -96.799669;
    [arrayQuests addObject:questObject];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Quests"];
    [query includeKey:@"questGiver"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *onlineQuests, NSError *error)
    {
        if (!error)
        {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu quests.", (unsigned long)onlineQuests.count);
            // Do something with the found objects
            for (PFObject *quest in onlineQuests)
            {
                Quest *downloadedQuest = [[Quest alloc] init];
                downloadedQuest.questTitle = quest[@"name"];
                downloadedQuest.alignment = [quest[@"alignment"]intValue];
                downloadedQuest.description = quest.description;
                
                PFGeoPoint *questGeoPoint = quest[@"location"];
                downloadedQuest.questLatitude = questGeoPoint.latitude;
                downloadedQuest.questLongitude = questGeoPoint.longitude;
                
                PFUser *giver = quest[@"questGiver"];
                downloadedQuest.giver= giver[@"name"];
                
                PFGeoPoint *giverGeoPoint = quest[@"location"];
                downloadedQuest.giverLatitude = giverGeoPoint.latitude;
                downloadedQuest.giverLongitude = giverGeoPoint.longitude;
                
                [arrayQuests addObject:downloadedQuest];
                
                NSLog(@"%@", quest.objectId);
            }
        }
        else
        {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    
    return arrayQuests;
}




@end
