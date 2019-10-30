//
//  SharedTransferForm.h
//  DevJummum
//
//  Created by Thidaporn Kijkamjai on 12/3/2562 BE.
//  Copyright © 2562 Jummum Tech. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SharedTransferForm : NSObject
@property (retain, nonatomic) NSMutableArray *transferFormList;

+ (SharedTransferForm *)sharedTransferForm;
@end

NS_ASSUME_NONNULL_END
