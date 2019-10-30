//
//  LuckyDrawBranchViewController.h
//  DemoJummum
//
//  Created by Thidaporn Kijkamjai on 8/10/2562 BE.
//  Copyright © 2562 Jummum Tech. All rights reserved.
//

#import "CustomViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LuckyDrawBranchViewController : CustomViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *lblNavTitle;
@property (strong, nonatomic) IBOutlet UITableView *tbvData;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topViewHeight;

- (IBAction)goBack:(id)sender;

@end

NS_ASSUME_NONNULL_END
