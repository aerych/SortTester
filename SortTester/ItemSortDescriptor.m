//
//  ItemSortDescriptor.m
//  SortTester
//
//  Created by aerych on 6/4/15.
//  Copyright (c) 2015 Aerych. All rights reserved.
//

#import "ItemSortDescriptor.h"

@implementation ItemSortDescriptor

- (instancetype)initWithKey:(NSString *)key ascending:(BOOL)ascending
{
    NSLog(@"%@, %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    self = [super initWithKey:key ascending:ascending];

    return self;
}

- (instancetype)initWithKey:(NSString *)key ascending:(BOOL)ascending selector:(SEL)selector
{
    NSLog(@"%@, %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    self = [super initWithKey:key ascending:ascending selector:selector];

    return self;
}

- (NSComparisonResult)compare:(id)other
{
    NSLog(@"%@, %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    return NSOrderedSame;
}

// Three is the magic number or this test.  If the number is a 3, always
// have it first in the list. 
- (NSComparisonResult)compareObject:(id)object1 toObject:(id)object2
{
    NSLog(@"%@, %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    NSLog(@"object1: %@, object2 %@", object1, object2);

    NSComparisonResult result = self.ascending ? NSOrderedAscending : NSOrderedDescending;
    NSInteger num1 = [object1 integerValue];
    NSInteger num2 = [object2 integerValue];
    if (num1 == num2) {
        return NSOrderedSame;
    }
    if (num1 == 3) {
        return result;
    }

    if (num2 == 3) {
        return result;
    }

    return [super compareObject:object1 toObject:object2];
}

- (instancetype)reversedSortDescriptor
{
    NSLog(@"%@, %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    return [[[self class] alloc] initWithKey:self.key ascending:!self.ascending selector:self.selector];
}


@end
