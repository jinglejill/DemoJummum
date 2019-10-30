//
//  Bank.h
//  DevJummum
//
//  Created by Thidaporn Kijkamjai on 12/3/2562 BE.
//  Copyright © 2562 Jummum Tech. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Bank : NSObject
@property (nonatomic) NSInteger bankID;
@property (retain, nonatomic) NSString * bankName;
@property (retain, nonatomic) NSString * bankNameEn;
@property (retain, nonatomic) NSString * imageUrl;
@property (retain, nonatomic) NSString * modifiedUser;
@property (retain, nonatomic) NSDate * modifiedDate;

- (NSDictionary *)dictionary;
-(Bank *)initWithBankName:(NSString *)bankName bankNameEn:(NSString *)bankNameEn imageUrl:(NSString *)imageUrl;
+(NSInteger)getNextID;
+(void)addObject:(Bank *)bank;
+(void)removeObject:(Bank *)bank;
+(void)addList:(NSMutableArray *)bankList;
+(void)removeList:(NSMutableArray *)bankList;
+(Bank *)getBank:(NSInteger)bankID;
-(BOOL)editBank:(Bank *)editingBank;
+(Bank *)copyFrom:(Bank *)fromBank to:(Bank *)toBank;

@end

NS_ASSUME_NONNULL_END
