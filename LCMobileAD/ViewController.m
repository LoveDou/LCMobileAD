//
//  ViewController.m
//  AltamobSDKTest
//
//  Created by zjw1 on 2017/1/9.
//  Copyright © 2017年 Altamob. All rights reserved.
//

#import "ViewController.h"
#import <UIImageView+WebCache.h>
#import <AltamobAdSDK/AltamobAdSDK.h>
#import "TableViewCell.h"

@interface ViewController ()
<AMNativeAdDelegate,
UITableViewDelegate,
UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

- (IBAction)loadAction:(id)sender {
    AMNativeAdService *adService = [AMNativeAdService defaultService];
    adService.delegate = self;
    [adService loadAdsWithPlacementId:@"1662684189370000_1769833153868098" count:6];
    
    self.title = @"加载中...";
    
    [self.tableView reloadData];
}


#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    AMNativeAd *ad = self.dataArray[indexPath.row];
    
    AMNativeAdService *nativeAdService = [AMNativeAdService defaultService];
    [nativeAdService registerViewForInteraction:ad
                             withClickableViews:@[cell.postView]];
    [cell.postView sd_setImageWithURL:[NSURL URLWithString:ad.coverUrl]];
    cell.indexLabel.text = [NSString stringWithFormat:@"%zd", indexPath.row + 1];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.tableView.frame.size.width / 3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

#pragma mark - AMNativeAdDelegate


- (void)nativeAdService:(AMNativeAdService *)nativeAdService didLoadedAds:(NSArray<AMNativeAd *> *)nativeAds withPlacementId:(NSString *)placementId
{
    self.dataArray = nativeAds;
    self.title = [NSString stringWithFormat:@"加载成功(%zd条广告)", nativeAds.count];
    [self.tableView reloadData];
}

- (void)nativeAdService:(AMNativeAdService *)nativeAdService loadFailed:(NSError *)error withPlacementId:(NSString *)placementId
{
    NSLog(@"nativeAdLoadFailed");
    self.title = @"加载失败";
}

- (void)nativeAdService:(AMNativeAdService *)nativeAdService didClick:(AMNativeAd *)ad withPlacementId:(NSString *)placementId
{
    NSLog(@"click");
}

- (void)nativeAdService:(AMNativeAdService *)nativeAdService didShow:(AMNativeAd *)ad withPlacementId:(NSString *)placementId
{
    NSLog(@"show");
}

@end
