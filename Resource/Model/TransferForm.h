//
//  TransferForm.h
//  DevJummum
//
//  Created by Thidaporn Kijkamjai on 12/3/2562 BE.
//  Copyright © 2562 Jummum Tech. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TransferForm : NSObject
@property (nonatomic) NSInteger transferFormID;
@property (nonatomic) NSInteger receiptID;
@property (nonatomic) float amount;
@property (nonatomic) NSInteger bankID;
@property (retain, nonatomic) NSString * bankAccountNo;
@property (retain, nonatomic) NSString * phoneNo;
@property (retain, nonatomic) NSString * remark;
@property (retain, nonatomic) NSString * modifiedUser;
@property (retain, nonatomic) NSDate * modifiedDate;

- (NSDictionary *)dictionary;
-(TransferForm *)initWithReceiptID:(NSInteger)receiptID amount:(float)amount bankID:(NSInteger)bankID bankAccountNo:(NSString *)bankAccountNo phoneNo:(NSString *)phoneNo remark:(NSString *)remark;
+(NSInteger)getNextID;
+(void)addObject:(TransferForm *)transferForm;
+(void)removeObject:(TransferForm *)transferForm;
+(void)addList:(NSMutableArray *)transferFormList;
+(void)removeList:(NSMutableArray *)transferFormList;
+(TransferForm *)getTransferForm:(NSInteger)transferFormID;
-(BOOL)editTransferForm:(TransferForm *)editingTransferForm;
+(TransferForm *)copyFrom:(TransferForm *)fromTransferForm to:(TransferForm *)toTransferForm;

@end

NS_ASSUME_NONNULL_END
