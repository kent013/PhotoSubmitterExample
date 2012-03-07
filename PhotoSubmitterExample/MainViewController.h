//
//  MainViewController.h
//  PhotoSubmitterExample
//
//  Created by Kentaro ISHITOYA on 12/03/07.
//  Copyright (c) 2012 Kentaro ISHITOYA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoSubmitterSettingTableViewController.h"
#import "PhotoSubmitterProtocol.h"

@interface MainViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, PhotoSubmitterSettingTableViewControllerDelegate, PhotoSubmitterPhotoDelegate, PhotoSubmitterAuthControllerDelegate>{
    PhotoSubmitterSettingTableViewController *settingViewController_;
    UINavigationController *settingNavigationController_;
    UIImagePickerController *imagePicker_;
}

@end
