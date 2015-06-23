//
//  ViewController.h
//  myBloggerForiOS
//
//  Created by Saito Keisei on 6/23/15.
//  Copyright (c) 2015 keisei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *titleTextField;
@property (strong, nonatomic) IBOutlet UITextField *categoryTextField;
@property (strong, nonatomic) IBOutlet UITextField *articleIDTextField;
@property (strong, nonatomic) IBOutlet UITextView *contentTextView;
@property (strong, nonatomic) IBOutlet UITextField *pukeTextField;

- (IBAction)postButton:(UIButton *)sender;
- (IBAction)getButton:(UIButton *)sender;
- (IBAction)putButton:(UIButton *)sender;
- (IBAction)pukeButton:(UIButton *)sender;


@end

