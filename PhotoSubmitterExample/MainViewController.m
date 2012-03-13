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
/*!
 * initialization
 */
- (void)setupInitialState{
    //You can enable specific services like this
    //[PhotoSubmitterManager unregisterAllPhotoSubmitters];
    //[PhotoSubmitterManager registerPhotoSubmitterWithTypeNames:[NSArray arrayWithObjects: @"facebook", @"twitter", @"dropbox", @"minus", @"file", nil]];
    
    //these three delegates are important.
    [[PhotoSubmitterManager sharedInstance] addPhotoDelegate:self];
    [PhotoSubmitterManager sharedInstance].authControllerDelegate = self;
    [PhotoSubmitterManager sharedInstance].submitPhotoWithOperations = YES;
    
    //UI implementation
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
    
    //initialize setting view controller
    settingViewController_ = [[PhotoSubmitterSettingTableViewController alloc] init];
    settingViewController_.delegate = self;
    settingNavigationController_ = [[UINavigationController alloc] initWithRootViewController:settingViewController_];
    settingNavigationController_.modalPresentationStyle = UIModalPresentationFormSheet;
    settingNavigationController_.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
}

/*!
 * camera button tapped, present UIImagePickerController
 */
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

/*!
 * setting button tapped, present SettingView
 */
- (void) handleShowSettingButtonTapped:(UIButton *)sender{
    [UIApplication sharedApplication].statusBarHidden = NO;
    [self presentModalViewController:settingNavigationController_ animated:YES];
}

@end

//-----------------------------------------------------------------------------
//Public Implementations
//-----------------------------------------------------------------------------
@implementation MainViewController
/*!
 * initialization
 */
- (id)init{
    self = [super init];
    if(self){
        [self setupInitialState];
    }
    return self;
}

/*!
 * when the photo taken, submit photo to logined services
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    PhotoSubmitterImageEntity *photo = [[PhotoSubmitterImageEntity alloc] initWithImage:image];
    [[PhotoSubmitterManager sharedInstance] submitPhoto:photo];
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - PhotoSubmitterAuthControllerDelegate
/*!
 * return navigation controller to present authentication view
 */
- (UINavigationController *)requestNavigationControllerToPresentAuthenticationView{
    return settingNavigationController_;
}

#pragma mark - PhotoSubmitterPhotoDelegate
/*!
 * photo did submitted
 */
- (void)photoSubmitter:(id<PhotoSubmitterProtocol>)photoSubmitter didSubmitted:(NSString *)imageHash suceeded:(BOOL)suceeded message:(NSString *)message{
    NSLog(@"submitted: %@,%d,%@", imageHash,suceeded,message);
}

/*!
 * progress changed
 */
- (void)photoSubmitter:(id<PhotoSubmitterProtocol>)photoSubmitter didProgressChanged:(NSString *)imageHash progress:(CGFloat)progress{
    NSLog(@"progress: %@,%f",imageHash,progress);
}

/*!
 * photo did canceled
 */
- (void)photoSubmitter:(id<PhotoSubmitterProtocol>)photoSubmitter didCanceled:(NSString *)imageHash{
}

/*!
 * photo will statrt upload
 */
- (void)photoSubmitter:(id<PhotoSubmitterProtocol>)photoSubmitter willStartUpload:(NSString *)imageHash{    
}

#pragma mark - PhotoSubmitterSettingViewControllerDelegate
/*!
 * setting view dismissed
 */
- (void)didDismissSettingTableViewController{
}
@end
