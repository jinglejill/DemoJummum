//
//  CustomTableViewCellImageLabelText.h
//  DevJummum
//
//  Created by Thidaporn Kijkamjai on 18/3/2562 BE.
//  Copyright © 2562 Jummum Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomTableViewCellImageLabelText : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imgVwIcon;
@property (strong, nonatomic) IBOutlet UILabel *lblText;
@property (strong, nonatomic) IBOutlet UITextField *txtValue;
@end

NS_ASSUME_NONNULL_END
