//
//  ConfirmTransferFormViewController.h
//  DevJummum
//
//  Created by Thidaporn Kijkamjai on 12/3/2562 BE.
//  Copyright © 2562 Jummum Tech. All rights reserved.
//

#import "CustomViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ConfirmTransferFormViewController : CustomViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
@property (strong, nonatomic) IBOutlet UILabel *lblNavTitle;
@property (strong, nonatomic) IBOutlet UITableView *tbvData;
@property (strong, nonatomic) IBOutlet UITableView *tbvAction;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerVw;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topViewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeight;


@property (nonatomic) Receipt *receipt;
- (IBAction)goBack:(id)sender;

@end

NS_ASSUME_NONNULL_END
