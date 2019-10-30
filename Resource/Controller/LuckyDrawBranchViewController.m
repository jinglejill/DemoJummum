//
//  LuckyDrawBranchViewController.m
//  DemoJummum
//
//  Created by Thidaporn Kijkamjai on 8/10/2562 BE.
//  Copyright © 2562 Jummum Tech. All rights reserved.
//

#import "LuckyDrawBranchViewController.h"
#import "LuckyDrawViewController.h"
#import "CustomTableViewCellReward.h"
#import "Branch.h"
#import "Receipt.h"

@interface LuckyDrawBranchViewController ()
{
    NSMutableArray *_branchList;
    Branch *_selectedBranch;
}
@end

@implementation LuckyDrawBranchViewController
//static NSString * const reuseIdentifierMenu = @"CustomTableViewCellMenu";
static NSString * const reuseIdentifierReward = @"CustomTableViewCellReward";


@synthesize lblNavTitle;
@synthesize tbvData;
@synthesize topViewHeight;

-(IBAction)unwindToLuckyDrawBranch:(UIStoryboardSegue *)segue
{
    
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    UIWindow *window = UIApplication.sharedApplication.keyWindow;
    
    
    float topPadding = window.safeAreaInsets.top;
    topViewHeight.constant = topPadding == 0?20:topPadding;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSString *title = [Language getText:@"สิทธิ์จับรางวัลของฉัน"];
    lblNavTitle.text = title;
    
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
//    _expandCollapse = 1;
    tbvData.delegate = self;
    tbvData.dataSource = self;
    tbvData.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
//    {
//        UINib *nib = [UINib nibWithNibName:reuseIdentifierMenu bundle:nil];
//        [tbvData registerNib:nib forCellReuseIdentifier:reuseIdentifierMenu];
//    }
    {
        UINib *nib = [UINib nibWithNibName:reuseIdentifierReward bundle:nil];
        [tbvData registerNib:nib forCellReuseIdentifier:reuseIdentifierReward];
    }
    
    
    UserAccount *userAccount = [UserAccount getCurrentUserAccount];
    self.homeModel = [[HomeModel alloc]init];
    self.homeModel.delegate = self;
    [self.homeModel downloadItems:dbLuckyDrawBranchList withData:userAccount];
    
}

///tableview section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    return [_branchList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger item = indexPath.item;
    
    
    CustomTableViewCellReward *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierReward];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;


    Branch *branch = _branchList[item];

    cell.lblHeader.text = branch.name;
    cell.lblSubTitle.text = [NSString stringWithFormat:@"%ld %@",branch.luckyDrawTicketCount,[Language getText:@"times"]];
    cell.lblHeader.hidden = NO;
    cell.lblSubTitle.hidden = NO;
    cell.lblRemark.hidden = YES;
    cell.lblCountDown.hidden = YES;
    cell.imgChefHat.hidden = YES;
    



    NSString *noImageFileName = [NSString stringWithFormat:@"/JMM/%@/Image/NoImage.jpg",branch.dbName];
    NSString *imageFileName = [NSString stringWithFormat:@"/JMM/%@/Image/Logo/%@",branch.dbName,branch.imageUrl];
    imageFileName = [Utility isStringEmpty:branch.imageUrl]?noImageFileName:imageFileName;
    UIImage *image = [Utility getImageFromCache:imageFileName];
    if(image)
    {
        cell.imgVwValue.image = image;
    }
    else
    {
        [self.homeModel downloadImageWithFileName:branch.imageUrl type:2 branchID:branch.branchID completionBlock:^(BOOL succeeded, UIImage *image)
         {
             if (succeeded)
             {
                 [Utility saveImageInCache:image imageName:imageFileName];
                 cell.imgVwValue.image = image;
             }
         }];
    }
    cell.imgVwValue.contentMode = UIViewContentModeScaleAspectFit;
    [self setImageDesign:cell.imgVwValue];


    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (void)tableView: (UITableView*)tableView willDisplayCell: (UITableViewCell*)cell forRowAtIndexPath: (NSIndexPath*)indexPath
{
    cell.backgroundColor = [UIColor whiteColor];
    [cell setSeparatorInset:UIEdgeInsetsMake(16, 16, 16, 16)];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedBranch = _branchList[indexPath.item];
    [self performSegueWithIdentifier:@"segLuckyDraw" sender:self];
    
}


- (IBAction)goBack:(id)sender
{
    [self performSegueWithIdentifier:@"segUnwindToReward" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"segLuckyDraw"])
    {
        UserAccount *userAccount = [UserAccount getCurrentUserAccount];
        LuckyDrawViewController *vc = segue.destinationViewController;
        Receipt *receipt = [[Receipt alloc]init];
        receipt.memberID = userAccount.userAccountID;
        receipt.branchID = _selectedBranch.branchID;
        vc.receipt = receipt;
        vc.fromLuckyDrawBranch = 1;
    }
}

-(void)itemsDownloaded:(NSArray *)items manager:(NSObject *)objHomeModel
{
    HomeModel *homeModel = (HomeModel *)objHomeModel;
    if(homeModel.propCurrentDB == dbLuckyDrawBranchList)
    {
        [self removeOverlayViews];
        [Utility updateSharedObject:items];
        
        
        _branchList = items[0];
        
        
        [tbvData reloadData];
    }
}
@end
