//
//  XLScannerController.m
//  iOSDemo
//
//  Created by AlexSiu on 2019/4/25.
//  Copyright © 2019 AlexSiu. All rights reserved.
//

#import "XLScannerController.h"
#import <AVKit/AVKit.h>
#import "XLQRCodeAreaView.h"

@interface XLScannerController ()<AVCaptureMetadataOutputObjectsDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) AVCaptureDevice * device;
@property (nonatomic, strong) AVCaptureDeviceInput * input;
@property (nonatomic, strong) AVCaptureMetadataOutput * output;
@property (nonatomic, strong) AVCaptureSession * session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer * preview;
@property (nonatomic, strong) XLQRCodeAreaView * qrCodeAreaView;
@property (nonatomic, strong) UILabel * tipsLabel;

@property (nonatomic, strong) UIView * topMaskView;
@property (nonatomic, strong) UIView * leftMaskView;
@property (nonatomic, strong) UIView * bottomMaskView;
@property (nonatomic, strong) UIView * rightMaskView;
@end

@implementation XLScannerController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"扫一扫";
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.qrCodeAreaView];
    [self addMaskView];
    [self.view addSubview:self.tipsLabel];
    
    UIBarButtonItem * albumButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(openPhotoAlbum)];
    self.navigationItem.rightBarButtonItem = albumButtonItem;
    
    [self initScanner];
}

#pragma mark - getter

- (XLQRCodeAreaView *)qrCodeAreaView
{
    if (!_qrCodeAreaView)
    {
        _qrCodeAreaView = [[XLQRCodeAreaView alloc] init];
    }
    
    return _qrCodeAreaView;
}

- (void)initScanner
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
        self.output = [[AVCaptureMetadataOutput alloc] init];
        [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        
        self.session = [[AVCaptureSession alloc]init];
        [self.session setSessionPreset:AVCaptureSessionPresetHigh];
        
        // 连接输入和输出
        if ([self.session canAddInput:self.input])
        {
            [self.session addInput:self.input];
        }
        
        if ([self.session canAddOutput:self.output])
        {
            [self.session addOutput:self.output];
        }
        
        self.output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // 添加扫描画面
            self.preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
            self.preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
            self.preview.frame = self.view.layer.bounds;
            [self.view.layer insertSublayer:self.preview atIndex:0];
            
            /**
             *  设置扫描区域
             *  注意：这里很坑爹，坐标是相对横屏下的 AVCaptureVideoPreviewLayer 中的比例
             */
            CGFloat viewHeight = self.preview.bounds.size.height;
            CGFloat viewWidth = self.preview.bounds.size.width;
            CGFloat qrCodeAreaSize = viewWidth - 100;
            
            CGRect videoPreviewFrame = self.preview.frame;
            CGRect rect = ({
                //竖屏时 二维码扫描框frame
                CGRect portraitScanningRect = CGRectMake(50, (viewHeight - qrCodeAreaSize) / 2.0, qrCodeAreaSize, qrCodeAreaSize);
                //横屏时 AVCaptureVideoPreviewLayer size
                CGSize landscapePreviewSize = CGSizeMake(CGRectGetHeight(videoPreviewFrame), CGRectGetWidth(videoPreviewFrame));
                //横屏时 二维码扫描狂frame
                CGRect landscapeScanningRect = ({
                    CGRect rect;
                    rect.origin = CGPointMake(portraitScanningRect.origin.y, landscapePreviewSize.height - CGRectGetMaxX(portraitScanningRect));
                    rect.size = CGSizeMake(CGRectGetHeight(portraitScanningRect), CGRectGetWidth(portraitScanningRect));
                    rect;
                });
                //预设视频输入高宽比
                CGFloat p1 = 1080./1920.;
                //AVCaptureVideoPreviewLayer 高宽比
                CGFloat p2 = landscapePreviewSize.height / landscapePreviewSize.width;
                /**
                 屏幕高宽比 和 视频预设不相符时，需要做适当修正
                 */
                CGRect rectOfInterest = ({
                    CGRect rect;
                    if (p1 < p2) {//屏幕宽度小于预设宽度，需对x进行修正
                        CGFloat fitWidth = landscapePreviewSize.height / p1;//(当前实际高度对应的预设宽度)
                        CGFloat xOffset = (fitWidth - landscapePreviewSize.width) / 2;
                        rect.origin.x = (landscapeScanningRect.origin.x + xOffset)/landscapePreviewSize.width;
                        rect.origin.y = landscapeScanningRect.origin.y / landscapePreviewSize.height;
                    } else {//屏幕高度小于预设高度，需对y进行修正
                        CGFloat fitHeight = landscapePreviewSize.width * p1;//(当前实际宽度对应的预设高度)
                        CGFloat yOffset = (fitHeight - landscapePreviewSize.height) / 2;
                        rect.origin.x = landscapeScanningRect.origin.x / landscapePreviewSize.width;
                        rect.origin.y = (landscapeScanningRect.origin.y + yOffset)/landscapePreviewSize.height;
                    }
                    rect.size.width = CGRectGetWidth(landscapeScanningRect) / landscapePreviewSize.width;
                    rect.size.height = CGRectGetHeight(landscapeScanningRect) / landscapePreviewSize.height;
                    rect;
                });
                rectOfInterest;
            });
            
            self.output.rectOfInterest = rect;
            [self.session startRunning];
        });
    });
}

- (void)addMaskView
{
    _topMaskView = [self makeMaskView];
    _leftMaskView = [self makeMaskView];
    _bottomMaskView = [self makeMaskView];
    _rightMaskView = [self makeMaskView];
    
    [self.view addSubview:self.topMaskView];
    [self.view addSubview:self.leftMaskView];
    [self.view addSubview:self.bottomMaskView];
    [self.view addSubview:self.rightMaskView];
}

- (UIView *)makeMaskView
{
    UIView * maskView = [[UIView alloc] init];
    maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    return maskView;
}

- (UILabel *)tipsLabel
{
    if (!_tipsLabel)
    {
        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.text = @"将二维码放入框内，即可自动扫描";
        _tipsLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        _tipsLabel.textColor = [UIColor colorWithRed:158/255.0 green:155/255.0 blue:155/255.0 alpha:1];
    }
    
    return _tipsLabel;
}

#pragma mark - UINavigationControllerDelegate, UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    NSString * scannedResult = nil;
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    CIDetector * detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    for (int index = 0; index < [features count]; index ++)
    {
        CIQRCodeFeature * feature = [features objectAtIndex:index];
        scannedResult = feature.messageString;
        if (scannedResult.length > 0)
        {
            break;
        }
    }
    
    if (scannedResult.length > 0)
    {
        [self scanResult:scannedResult];
    }
//    else
//    {
//        [XLToast showText:@"未发现二维码" inView:self.view];
//    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        [self setNeedsStatusBarAppearanceUpdate];
    }];
}

#pragma mark - action
- (void)openPhotoAlbum
{
    UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePicker.delegate = self;

    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)scanResult:(NSString *)result
{
    BOOL success = NO;
    NSString * resultString = nil;
    if (result.length > 0)
    {
        resultString = result;
        success = YES;
    }
    
    if (self.scannerCallback)
    {
        self.scannerCallback(success, resultString, self);
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString * stringValue;
    if ([metadataObjects count] > 0)
    {
        //停止扫描
        [_session stopRunning];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    
    if (stringValue.length > 0)
    {
        [self scanResult:stringValue];
    }
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGFloat qrCodeAreaSize = self.view.width - 100;
    self.qrCodeAreaView.size = CGSizeMake(qrCodeAreaSize, qrCodeAreaSize);
    self.qrCodeAreaView.center = self.view.center;
    
    [self.tipsLabel sizeToFit];
    self.tipsLabel.top = self.qrCodeAreaView.bottom + 20;
    self.tipsLabel.centerX = self.qrCodeAreaView.centerX;
    
    self.topMaskView.frame = CGRectMake(0, 0, self.view.width, self.qrCodeAreaView.top);
    self.leftMaskView.frame = CGRectMake(0, self.qrCodeAreaView.top, (self.view.width - qrCodeAreaSize) / 2.0, qrCodeAreaSize);
    self.bottomMaskView.frame = CGRectMake(0, self.qrCodeAreaView.bottom, self.view.width, self.view.height - self.qrCodeAreaView.bottom);
    self.rightMaskView.frame = CGRectMake(self.qrCodeAreaView.right, self.qrCodeAreaView.top, (self.view.width - qrCodeAreaSize) / 2.0, qrCodeAreaSize);
}
@end


