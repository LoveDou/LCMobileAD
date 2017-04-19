//
//  ADViewController.m
//  AltamobSDKTest
//
//  Created by luochao on 2017/3/29.
//  Copyright © 2017年 Altamob. All rights reserved.
//

#import "ADViewController.h"
#import <UIImageView+WebCache.h>
#import <AltamobAdSDK/AltamobAdSDK.h>

#import <Masonry.h>

@interface ADViewController ()<AMNativeAdDelegate>

@property (weak, nonatomic) IBOutlet UIButton *loadBtn;

@property (weak, nonatomic) IBOutlet UIView *altaAdView;
@property (weak, nonatomic) IBOutlet UIImageView *altaCoverImgView;
@property (weak, nonatomic) IBOutlet UILabel *altaTitleLabel;

@property (weak, nonatomic) IBOutlet UIView *fbAdView;
@property (weak, nonatomic) IBOutlet UIImageView *fbIconImgView;
@property (weak, nonatomic) IBOutlet UILabel *fbTitleLabel;

@property (nonatomic, strong) UIView *fbChoiceView;
@property (nonatomic, strong) UIView *fbMediaView;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ADViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loadAd:(id)sender {
    self.loadBtn.enabled = NO;
    self.title = @"加载中...";
    
    AMNativeAdService *adService = [AMNativeAdService defaultService];
    adService.delegate = self;
    //1662684189370000_1769833153868744
    [adService loadAdsWithPlacementId:@"1662684189370000_1769833153868513" count:3];
}

#pragma mark - UI

- (void)reloadDataWithNativeAd:(AMNativeAd *)ad
{
    AMNativeAdService *service = [AMNativeAdService defaultService];
    
    if (ad.amAdType == AMAltaAD) {
        self.altaAdView.hidden = NO;
        self.fbAdView.hidden = YES;
        [self.altaCoverImgView sd_setImageWithURL:[NSURL URLWithString:ad.coverUrl]];
        self.altaTitleLabel.text = ad.titile;
        [service registerViewForInteraction:ad
                         withClickableViews:@[self.altaTitleLabel,self.altaCoverImgView]
                                  currentVC:self];
    }
    else
    {
        if (self.fbChoiceView) {
            [self.fbChoiceView removeFromSuperview];
            [self.fbMediaView removeFromSuperview];
        }
        
        self.altaAdView.hidden = YES;
        self.fbAdView.hidden = NO;
        self.fbTitleLabel.text = ad.titile;
        [self.fbIconImgView sd_setImageWithURL:[NSURL URLWithString:ad.iconUrl]];
        self.fbChoiceView = [service fbChoiceViewWithNativeAd:ad];
        self.fbMediaView = [service fbMediaViewWithNativeAd:ad];
        if (self.fbMediaView) {
            [self.fbAdView addSubview:self.fbMediaView];
            [self.fbAdView addSubview:self.fbChoiceView];
            
            [self.fbMediaView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.fbAdView).offset(10);
                make.right.bottom.equalTo(self.fbAdView).offset(-10);
                make.top.equalTo(self.fbIconImgView.mas_bottom).offset(15);
            }];
            
            [self.fbChoiceView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.fbMediaView);
                make.top.equalTo(self.fbIconImgView);
                make.height.equalTo(@20);
                make.width.equalTo(@75);
            }];
        }
        [service registerViewForInteraction:ad
                         withClickableViews:@[self.fbAdView]
                                  currentVC:self];
    }
    
}

#pragma mark - AMNativeAdDelegate

- (void)nativeAdService:(AMNativeAdService *)nativeAdService
           didLoadedAds:(NSArray<AMNativeAd *> *)nativeAds
        withPlacementId:(NSString *)placementId
{
    self.dataArray = nativeAds;
    self.loadBtn.enabled = YES;
    self.title = [NSString stringWithFormat:@"加载成功(%zd条广告)", nativeAds.count];
    if (self.dataArray.count) {
        AMNativeAd *ad = self.dataArray[0];
        if (ad) {
            [self reloadDataWithNativeAd:ad];
        }
    }
}

- (void)nativeAdService:(AMNativeAdService *)nativeAdService loadFailed:(AMError *)error withPlacementId:(NSString *)placementId
{
    NSLog(@"nativeAdLoadFailed");
    self.loadBtn.enabled = YES;
    
    if ([error.errorDescription isEqualToString:@"操作太频繁"]) {
        self.title = error.errorDescription;
    }
    else
    {
        self.title = @"加载失败";
    }
}

- (void)nativeAdService:(AMNativeAdService *)nativeAdService didClick:(AMNativeAd *)ad withPlacementId:(NSString *)placementId
{
    NSLog(@"click");
}

- (void)nativeAdService:(AMNativeAdService *)nativeAdService didShow:(AMNativeAd *)ad withPlacementId:(NSString *)placementId
{
    NSLog(@"show");
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
