//
//  SharedBank.m
//  DevJummum
//
//  Created by Thidaporn Kijkamjai on 12/3/2562 BE.
//  Copyright © 2562 Jummum Tech. All rights reserved.
//

#import "SharedBank.h"

@implementation SharedBank
@synthesize bankList;

+(SharedBank *)sharedBank {
    static dispatch_once_t pred;
    static SharedBank *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[SharedBank alloc] init];
        shared.bankList = [[NSMutableArray alloc]init];
    });
    return shared;
}

@end
