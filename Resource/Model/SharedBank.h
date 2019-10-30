//
//  SharedBank.h
//  DevJummum
//
//  Created by Thidaporn Kijkamjai on 12/3/2562 BE.
//  Copyright © 2562 Jummum Tech. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SharedBank : NSObject
@property (retain, nonatomic) NSMutableArray *bankList;

+ (SharedBank *)sharedBank;
@end

NS_ASSUME_NONNULL_END
