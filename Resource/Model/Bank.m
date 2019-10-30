//
//  Bank.m
//  DevJummum
//
//  Created by Thidaporn Kijkamjai on 12/3/2562 BE.
//  Copyright © 2562 Jummum Tech. All rights reserved.
//

#import "Bank.h"
#import "SharedBank.h"
#import "Utility.h"


@implementation Bank

- (NSDictionary *)dictionary
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
        [self valueForKey:@"bankID"]?[self valueForKey:@"bankID"]:[NSNull null],@"bankID",
        [self valueForKey:@"bankName"]?[self valueForKey:@"bankName"]:[NSNull null],@"bankName",
        [self valueForKey:@"bankNameEn"]?[self valueForKey:@"bankNameEn"]:[NSNull null],@"bankNameEn",
        [self valueForKey:@"imageUrl"]?[self valueForKey:@"imageUrl"]:[NSNull null],@"imageUrl",
        [self valueForKey:@"modifiedUser"]?[self valueForKey:@"modifiedUser"]:[NSNull null],@"modifiedUser",
        [Utility dateToString:[self valueForKey:@"modifiedDate"] toFormat:@"yyyy-MM-dd HH:mm:ss"],@"modifiedDate",
        nil];
}

-(Bank *)initWithBankName:(NSString *)bankName bankNameEn:(NSString *)bankNameEn imageUrl:(NSString *)imageUrl
{
    self = [super init];
    if(self)
    {
        self.bankID = [Bank getNextID];
        self.bankName = bankName;
        self.bankNameEn = bankNameEn;
        self.imageUrl = imageUrl;
        self.modifiedUser = [Utility modifiedUser];
        self.modifiedDate = [Utility currentDateTime];
    }
    return self;
}

+(NSInteger)getNextID
{
    NSString *primaryKeyName = @"bankID";
    NSString *propertyName = [NSString stringWithFormat:@"_%@",primaryKeyName];
    NSMutableArray *dataList = [SharedBank sharedBank].bankList;


    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:propertyName ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    NSArray *sortArray = [dataList sortedArrayUsingDescriptors:sortDescriptors];
    dataList = [sortArray mutableCopy];

    if([dataList count] == 0)
    {
        return -1;
    }
    else
    {
        id value = [dataList[0] valueForKey:primaryKeyName];
        if([value integerValue]>0)
        {
            return -1;
        }
        else
        {
            return [value integerValue]-1;
        }
    }
}

+(void)addObject:(Bank *)bank
{
    NSMutableArray *dataList = [SharedBank sharedBank].bankList;
    [dataList addObject:bank];
}

+(void)removeObject:(Bank *)bank
{
    NSMutableArray *dataList = [SharedBank sharedBank].bankList;
    [dataList removeObject:bank];
}

+(void)addList:(NSMutableArray *)bankList
{
    NSMutableArray *dataList = [SharedBank sharedBank].bankList;
    [dataList addObjectsFromArray:bankList];
}

+(void)removeList:(NSMutableArray *)bankList
{
    NSMutableArray *dataList = [SharedBank sharedBank].bankList;
    [dataList removeObjectsInArray:bankList];
}

+(Bank *)getBank:(NSInteger)bankID
{
    NSMutableArray *dataList = [SharedBank sharedBank].bankList;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"_bankID = %ld",bankID];
    NSArray *filterArray = [dataList filteredArrayUsingPredicate:predicate];
    if([filterArray count] > 0)
    {
        return filterArray[0];
    }
    return nil;
}

-(id)copyWithZone:(NSZone *)zone
{
    id copy = [[[self class] alloc] init];

    if (copy)
    {
        ((Bank *)copy).bankID = self.bankID;
        [copy setBankName:self.bankName];
        [copy setBankNameEn:self.bankNameEn];
        [copy setImageUrl:self.imageUrl];
        [copy setModifiedUser:[Utility modifiedUser]];
        [copy setModifiedDate:[Utility currentDateTime]];
    }
    
    return copy;
}

-(BOOL)editBank:(Bank *)editingBank
{
    if(self.bankID == editingBank.bankID
    && [self.bankName isEqualToString:editingBank.bankName]
    && [self.bankNameEn isEqualToString:editingBank.bankNameEn]
    && [self.imageUrl isEqualToString:editingBank.imageUrl]
    )
    {
        return NO;
    }
    return YES;
}

+(Bank *)copyFrom:(Bank *)fromBank to:(Bank *)toBank
{
    toBank.bankID = fromBank.bankID;
    toBank.bankName = fromBank.bankName;
    toBank.bankNameEn = fromBank.bankNameEn;
    toBank.imageUrl = fromBank.imageUrl;
    toBank.modifiedUser = [Utility modifiedUser];
    toBank.modifiedDate = [Utility currentDateTime];
    
    return toBank;
}



@end
