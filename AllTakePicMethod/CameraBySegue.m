//
//  CameraBySegue.m
//  AllTakePicMethod
//
//  Created by Chin-Hui Hsieh  on 5/19/15.
//  Copyright (c) 2015 Chin-Hui Hsieh. All rights reserved.
//

#import "CameraBySegue.h"
#import "CameraBySegueVC2.h"

@interface CameraBySegue ()

@property (weak, nonatomic) IBOutlet UIView *showCameraStream;

@end

AVCaptureSession *session;
AVCaptureStillImageOutput *stillImageOutput;


@implementation CameraBySegue

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ///!!!: 建立session
    //建立session
    session = [[AVCaptureSession alloc] init];
    [session setSessionPreset:AVCaptureSessionPresetPhoto];
    //建立輸入裝置物件
    AVCaptureDevice *inputDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //建立儲存錯誤物件
    NSError *error;
    //建立輸入源
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:inputDevice error:&error];
    //將輸入源加入session
    if ([session canAddInput:deviceInput]) {
        [session addInput:deviceInput];
    }
    
    
    ///!!!: 建立sessionPreview 串流影片預覽
    AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:session];
    [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    /*
     AVLayerVideoGravityResize           不考慮畫面比例來fit frame (畫面變形）
     AVLayerVideoGravityResizeAspect     實際畫面,無縮放
     AVLayerVideoGravityResizeAspectFill 實際畫面,同縮放長寬比例來fit fream
     */
    
    CALayer *rootLayer = [[self view] layer];
    [rootLayer setMasksToBounds:YES];
    CGRect frame = self.showCameraStream.frame;
    [previewLayer setFrame:frame];
    [rootLayer insertSublayer:previewLayer atIndex:0];
    
    
    
    ///!!!: Output 建立 AVCaptureStillImageOutput
    stillImageOutput = [[AVCaptureStillImageOutput alloc]init];
    NSDictionary *outputSettings = [[NSDictionary alloc]initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey, nil];
    [stillImageOutput setOutputSettings:outputSettings];
    
    [session addOutput:stillImageOutput];

    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    //開始影像
    [session startRunning];
}

- (IBAction)takePicture:(id)sender {
    
    ///!!!:建立connection
    AVCaptureConnection *videoConnection = nil;
    
    for (AVCaptureConnection *connection in stillImageOutput.connections)
    {
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            if ([[port mediaType] isEqual:AVMediaTypeVideo]) {
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection) {
            break;
        }
    }
    
    //存照片
    [stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer != NULL)
        {
            //將串流資料用imageData接
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            //轉成UIImage格式
            UIImage *image = [UIImage imageWithData:imageData];
            
            //照片存到手機相簿
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
            
            //執行segue
            [self performSegueWithIdentifier:@"goToCameraBySegueVC2" sender:image];
            
        }else
        {
            [self performSegueWithIdentifier:@"goToCameraBySegueVC2" sender:nil];
        }
    }];

}


#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    CameraBySegueVC2 *view2 = [segue destinationViewController];
    view2.takeFromCemeraImage = sender;
    
    //換頁時停止攝影
    [session stopRunning];
}















@end
















