//
//  SharedTransferForm.m
//  DevJummum
//
//  Created by Thidaporn Kijkamjai on 12/3/2562 BE.
//  Copyright © 2562 Jummum Tech. All rights reserved.
//

#import "SharedTransferForm.h"

@implementation SharedTransferForm
@synthesize transferFormList;

+(SharedTransferForm *)sharedTransferForm {
    static dispatch_once_t pred;
    static SharedTransferForm *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[SharedTransferForm alloc] init];
        shared.transferFormList = [[NSMutableArray alloc]init];
    });
    return shared;
}

@end
