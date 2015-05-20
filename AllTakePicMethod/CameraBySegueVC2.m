//
//  CameraBySegueVC2.m
//  AllTakePicMethod
//
//  Created by Chin-Hui Hsieh  on 5/19/15.
//  Copyright (c) 2015 Chin-Hui Hsieh. All rights reserved.
//

#import "CameraBySegueVC2.h"

@interface CameraBySegueVC2 ()

@property (weak, nonatomic) IBOutlet UIImageView *showImageView;

@end



@implementation CameraBySegueVC2
@synthesize takeFromCemeraImage;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.showImageView.image = takeFromCemeraImage;
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
