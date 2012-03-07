//
//  MainViewController.m
//  PhotoSubmitterExample
//
//  Created by Kentaro ISHITOYA on 12/03/07.
//  Copyright (c) 2012 Kentaro ISHITOYA. All rights reserved.
//

#import "MainViewController.h"
#import "PhotoSubmitterManager.h"

//-----------------------------------------------------------------------------
//Private Implementations
//-----------------------------------------------------------------------------
@interface MainViewController(PrivateImplementation)
- (void) setupInitialState;
- (void) handleShowSettingButtonTapped:(UIButton *)sender;
- (void) handleShowCameraButtonTapped:(UIButton *)sender;
@end

@implementation MainViewController(PrivateImplementation)
- (void)setupInitialState{
    [[PhotoSubmitterManager sharedInstance] setPhotoDelegate:self];
    [PhotoSubmitterManager sharedInstance].submitPhotoWithOperations = YES;
    [PhotoSubmitterManager sharedInstance].authControllerDelegate = self;
    
    UIButton *showSettingButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [showSettingButton setTitle:@"Setting" forState:UIControlStateNormal];
    [showSettingButton setFrame:CGRectMake(self.view.frame.size.width / 2 - 40, self.view.frame.size.height / 2 - 70, 80, 30)];
    [showSettingButton addTarget:self action:@selector(handleShowSettingButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showSettingButton];
            
    UIButton *cameraButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [cameraButton setTitle:@"Camera" forState:UIControlStateNormal];
    [cameraButton setFrame:CGRectMake(self.view.frame.size.width / 2 - 40, self.view.frame.size.height / 2 + 35, 80, 30)];
    [cameraButton addTarget:self action:@selector(handleShowCameraButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cameraButton];
    
    
    settingViewController_ = 
    [[PhotoSubmitterSettingTableViewController alloc] init];
    settingNavigationController_ = [[UINavigationController alloc] initWithRootViewController:settingViewController_];
    settingNavigationController_.modalPresentationStyle = UIModalPresentationFormSheet;
    settingNavigationController_.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    settingViewController_.delegate = self;
}

- (void) handleShowCameraButtonTapped:(UIButton *)sender{
    if([UIImagePickerController
        isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *ipc = [[UIImagePickerController alloc] init]; 
        ipc.delegate = self;
        ipc.sourceType =
        UIImagePickerControllerSourceTypeCamera;
        ipc.allowsEditing = YES;
        [self presentModalViewController:ipc animated:YES];
        imagePicker_ = ipc;
    }
}

- (void) handleShowSettingButtonTapped:(UIButton *)sender{
    [UIApplication sharedApplication].statusBarHidden = NO;
    [self presentModalViewController:settingNavigationController_ animated:YES];
}

@end

//-----------------------------------------------------------------------------
//Public Implementations
//-----------------------------------------------------------------------------
@implementation MainViewController
- (id)init{
    self = [super init];
    if(self){
        [self setupInitialState];
    }
    return self;
}

- (void)didDismissSettingTableViewController{
}

- (UINavigationController *)requestNavigationControllerToPresentAuthenticationView{
    return settingNavigationController_;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    PhotoSubmitterImageEntity *photo = [[PhotoSubmitterImageEntity alloc] initWithImage:image];
    [[PhotoSubmitterManager sharedInstance] submitPhoto:photo];
    [self dismissModalViewControllerAnimated:YES];
}

- (void)photoSubmitter:(id<PhotoSubmitterProtocol>)photoSubmitter didSubmitted:(NSString *)imageHash suceeded:(BOOL)suceeded message:(NSString *)message{
    NSLog(@"submitted: %@,%d,%@", imageHash,suceeded,message);
}

- (void)photoSubmitter:(id<PhotoSubmitterProtocol>)photoSubmitter didProgressChanged:(NSString *)imageHash progress:(CGFloat)progress{
    NSLog(@"progress: %@,%f",imageHash,progress);
}

- (void)photoSubmitter:(id<PhotoSubmitterProtocol>)photoSubmitter didCanceled:(NSString *)imageHash{
}

- (void)photoSubmitter:(id<PhotoSubmitterProtocol>)photoSubmitter willStartUpload:(NSString *)imageHash{    
}
@end
