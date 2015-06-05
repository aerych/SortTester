//
//  ViewController.m
//  SortTester
//
//  Created by aerych on 6/4/15.
//  Copyright (c) 2015 Aerych. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Item.h"
#import "ItemSortDescriptor.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self tearDown];
    [self build];
    [self fetchAndSort];
}

- (void)fetchAndSort
{
    NSManagedObjectContext *context = [[self appDelegate] managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Item"];

    // ItemSortDescriptor is designed to always sort the list with the number 3 being first. 
    ItemSortDescriptor *sortDescriptor = [ItemSortDescriptor sortDescriptorWithKey:@"itemID" ascending:YES];
    fetchRequest.sortDescriptors = @[sortDescriptor];

    NSError *error;
    NSArray *results = [context executeFetchRequest:fetchRequest error:&error];

    NSLog(@" -------- ");
    for (Item *item in results) {
        NSLog(@"Item ID: %@", item.itemID);
    }
    NSLog(@" -------- ");
}

- (void)tearDown
{
    NSManagedObjectContext *context = [[self appDelegate] managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Item"];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"itemID" ascending:YES];
    fetchRequest.sortDescriptors = @[sortDescriptor];
    NSError *error;
    NSArray *results = [context executeFetchRequest:fetchRequest error:&error];
    for (Item *item in results) {
        [context deleteObject:item];
    }
    [[self appDelegate] saveContext];
}

- (void)build
{
    NSManagedObjectContext *context = [[self appDelegate] managedObjectContext];
    for (NSInteger i = 0; i < 10; i++) {
        Item *item = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:context];
        item.itemID = @(i);
    }
    [[self appDelegate] saveContext];
}

- (AppDelegate *)appDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

@end
