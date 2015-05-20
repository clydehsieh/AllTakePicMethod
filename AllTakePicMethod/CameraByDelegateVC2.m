//
//  CameraByDelegateVC2.m
//  AllTakePicMethod
//
//  Created by Chin-Hui Hsieh  on 5/20/15.
//  Copyright (c) 2015 Chin-Hui Hsieh. All rights reserved.
//

#import "CameraByDelegateVC2.h"
#import "CameraByDelegate.h"

@interface CameraByDelegateVC2 () <ShowCameraPictureDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *showImageView;
@property (nonatomic,retain) CameraByDelegate *cameraByDelegate;

@end

@implementation CameraByDelegateVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.cameraByDelegate.delegate=self;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showCameraPicture:(UIImage *)image
{
    self.showImageView.image = image;
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
