//
//  TransferForm.m
//  DevJummum
//
//  Created by Thidaporn Kijkamjai on 12/3/2562 BE.
//  Copyright © 2562 Jummum Tech. All rights reserved.
//

#import "TransferForm.h"
#import "SharedTransferForm.h"
#import "Utility.h"


@implementation TransferForm

- (NSDictionary *)dictionary
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
        [self valueForKey:@"transferFormID"]?[self valueForKey:@"transferFormID"]:[NSNull null],@"transferFormID",
        [self valueForKey:@"receiptID"]?[self valueForKey:@"receiptID"]:[NSNull null],@"receiptID",
        [self valueForKey:@"amount"]?[self valueForKey:@"amount"]:[NSNull null],@"amount",
        [self valueForKey:@"bankID"]?[self valueForKey:@"bankID"]:[NSNull null],@"bankID",
        [self valueForKey:@"bankAccountNo"]?[self valueForKey:@"bankAccountNo"]:[NSNull null],@"bankAccountNo",
        [self valueForKey:@"phoneNo"]?[self valueForKey:@"phoneNo"]:[NSNull null],@"phoneNo",
        [self valueForKey:@"remark"]?[self valueForKey:@"remark"]:[NSNull null],@"remark",
        [self valueForKey:@"modifiedUser"]?[self valueForKey:@"modifiedUser"]:[NSNull null],@"modifiedUser",
        [Utility dateToString:[self valueForKey:@"modifiedDate"] toFormat:@"yyyy-MM-dd HH:mm:ss"],@"modifiedDate",
        nil];
}

-(TransferForm *)initWithReceiptID:(NSInteger)receiptID amount:(float)amount bankID:(NSInteger)bankID bankAccountNo:(NSString *)bankAccountNo phoneNo:(NSString *)phoneNo remark:(NSString *)remark
{
    self = [super init];
    if(self)
    {
        self.transferFormID = [TransferForm getNextID];
        self.receiptID = receiptID;
        self.amount = amount;
        self.bankID = bankID;
        self.bankAccountNo = bankAccountNo;
        self.phoneNo = phoneNo;
        self.remark = remark;
        self.modifiedUser = [Utility modifiedUser];
        self.modifiedDate = [Utility currentDateTime];
    }
    return self;
}

+(NSInteger)getNextID
{
    NSString *primaryKeyName = @"transferFormID";
    NSString *propertyName = [NSString stringWithFormat:@"_%@",primaryKeyName];
    NSMutableArray *dataList = [SharedTransferForm sharedTransferForm].transferFormList;


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

+(void)addObject:(TransferForm *)transferForm
{
    NSMutableArray *dataList = [SharedTransferForm sharedTransferForm].transferFormList;
    [dataList addObject:transferForm];
}

+(void)removeObject:(TransferForm *)transferForm
{
    NSMutableArray *dataList = [SharedTransferForm sharedTransferForm].transferFormList;
    [dataList removeObject:transferForm];
}

+(void)addList:(NSMutableArray *)transferFormList
{
    NSMutableArray *dataList = [SharedTransferForm sharedTransferForm].transferFormList;
    [dataList addObjectsFromArray:transferFormList];
}

+(void)removeList:(NSMutableArray *)transferFormList
{
    NSMutableArray *dataList = [SharedTransferForm sharedTransferForm].transferFormList;
    [dataList removeObjectsInArray:transferFormList];
}

+(TransferForm *)getTransferForm:(NSInteger)transferFormID
{
    NSMutableArray *dataList = [SharedTransferForm sharedTransferForm].transferFormList;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"_transferFormID = %ld",transferFormID];
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
        ((TransferForm *)copy).transferFormID = self.transferFormID;
        ((TransferForm *)copy).receiptID = self.receiptID;
        ((TransferForm *)copy).amount = self.amount;
        ((TransferForm *)copy).bankID = self.bankID;
        [copy setBankAccountNo:self.bankAccountNo];
        [copy setPhoneNo:self.phoneNo];
        [copy setRemark:self.remark];
        [copy setModifiedUser:[Utility modifiedUser]];
        [copy setModifiedDate:[Utility currentDateTime]];
    }
    
    return copy;
}

-(BOOL)editTransferForm:(TransferForm *)editingTransferForm
{
    if(self.transferFormID == editingTransferForm.transferFormID
    && self.receiptID == editingTransferForm.receiptID
    && self.amount == editingTransferForm.amount
    && self.bankID == editingTransferForm.bankID
    && [self.bankAccountNo isEqualToString:editingTransferForm.bankAccountNo]
    && [self.phoneNo isEqualToString:editingTransferForm.phoneNo]
    && [self.remark isEqualToString:editingTransferForm.remark]
    )
    {
        return NO;
    }
    return YES;
}

+(TransferForm *)copyFrom:(TransferForm *)fromTransferForm to:(TransferForm *)toTransferForm
{
    toTransferForm.transferFormID = fromTransferForm.transferFormID;
    toTransferForm.receiptID = fromTransferForm.receiptID;
    toTransferForm.amount = fromTransferForm.amount;
    toTransferForm.bankID = fromTransferForm.bankID;
    toTransferForm.bankAccountNo = fromTransferForm.bankAccountNo;
    toTransferForm.phoneNo = fromTransferForm.phoneNo;
    toTransferForm.remark = fromTransferForm.remark;
    toTransferForm.modifiedUser = [Utility modifiedUser];
    toTransferForm.modifiedDate = [Utility currentDateTime];
    
    return toTransferForm;
}

@end
