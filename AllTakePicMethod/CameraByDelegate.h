//
//  CameraByDelegate.h
//  AllTakePicMethod
//
//  Created by Chin-Hui Hsieh  on 5/20/15.
//  Copyright (c) 2015 Chin-Hui Hsieh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol ShowCameraPictureDelegate <NSObject>

@optional
-(void) showCameraPicture:(UIImage *)image;

@end



@interface CameraByDelegate : UIViewController

@property (nonatomic) id<ShowCameraPictureDelegate> delegate;

@end
