//
//  CameraByDelegate.m
//  AllTakePicMethod
//
//  Created by Chin-Hui Hsieh  on 5/20/15.
//  Copyright (c) 2015 Chin-Hui Hsieh. All rights reserved.
//

#import "CameraByDelegate.h"
#import "CameraByDelegateVC2.h"


@interface CameraByDelegate ()

@property (weak, nonatomic) IBOutlet UIView *showCameraStream;

@end

AVCaptureSession *session2;
AVCaptureStillImageOutput *stillImageOutput2;

@implementation CameraByDelegate
@synthesize delegate;


- (void)viewDidLoad {
    [super viewDidLoad];

    session2 = [[AVCaptureSession alloc]init];
    [session2 setSessionPreset:AVCaptureSessionPresetPhoto];
    
    AVCaptureDevice *inputDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error;
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:inputDevice error:&error];
    
    if ([session2 canAddInput:deviceInput]) {
        [session2 addInput:deviceInput];
    }
    
    AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session2];
    [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    
    CALayer *rootLayer = [[self view]layer];
    [rootLayer setMasksToBounds:YES];
    CGRect frame = self.showCameraStream.frame;
    [previewLayer setFrame:frame];
    [rootLayer insertSublayer:previewLayer atIndex:0];
    
    stillImageOutput2 = [[AVCaptureStillImageOutput alloc]init];
    NSDictionary *outputSettings = [[NSDictionary alloc]initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey, nil];
    [stillImageOutput2 setOutputSettings:outputSettings];
    
    [session2 addOutput:stillImageOutput2];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [session2 startRunning];
}

- (IBAction)takePicture:(id)sender {
    
    AVCaptureConnection *videoConnection = nil;
    
    for (AVCaptureConnection *connection in stillImageOutput2.connections) {
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
    
    [stillImageOutput2 captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer != NULL) {
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            
            UIImage *image = [UIImage imageWithData:imageData];
            
            UIImageWriteToSavedPhotosAlbum(image, nil, nil,nil);
            
            
            ///!!!: Delegate傳值
            
            [self.delegate showCameraPicture:image];
            
            
            //跳轉ＶＣ頁面
            CameraByDelegateVC2 *cameraVC1 = [self.storyboard instantiateViewControllerWithIdentifier:@"CameraByDelegateVC2"];
            [self.navigationController pushViewController:cameraVC1 animated:YES];
        
        }else
        {
            [self.delegate showCameraPicture:nil];
        }
    }];
    
    
    
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

















