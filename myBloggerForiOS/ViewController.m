//
//  ViewController.m
//  myBloggerForiOS
//
//  Created by Saito Keisei on 6/23/15.
//  Copyright (c) 2015 keisei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _titleTextField.returnKeyType = UIReturnKeyDone;
    _titleTextField.delegate = self;
    _categoryTextField.returnKeyType = UIReturnKeyDone;
    _categoryTextField.delegate = self;
    _articleIDTextField.returnKeyType = UIReturnKeyDone;
    _articleIDTextField.delegate = self;
    _pukeTextField.returnKeyType = UIReturnKeyDone;
    _pukeTextField.delegate = self;
    
    UIView* accessoryView =[[UIView alloc] initWithFrame:CGRectMake(0,0,320,40)];
    accessoryView.backgroundColor = [UIColor clearColor];
    
    UIButton* closeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    closeButton.frame = CGRectMake(210,5,100,30);
    [closeButton setTitle:@" Done" forState:UIControlStateNormal];
    
    [closeButton addTarget:self action:@selector(closeKeyboard:) forControlEvents:UIControlEventTouchUpInside];
    
    [accessoryView addSubview:closeButton];
    
    _contentTextView.inputAccessoryView = accessoryView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)postButton:(UIButton *)sender {
    NSLog(@"\nTitle: %@\nCategory: %@\nContent: %@",
          _titleTextField.text,
          _categoryTextField.text,
          _contentTextView.text);
    NSString *post = [NSString stringWithFormat:@"{\"title\":\"%@\",\"category\":\"%@\",\"content\":\"%@\"}",
                      _titleTextField.text, _categoryTextField.text, _contentTextView.text];
    post = [post stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"\nSending data:\n%@", [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding]);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://inside.miraitoarumachi.com/articles.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSLog(@"%@", [request allHTTPHeaderFields]);
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(conn) {
        NSLog(@"Submit Successful");
    } else {
        NSLog(@"Submit could not be made");
    }

}

- (IBAction)getButton:(UIButton *)sender {
    NSString *url = [NSString stringWithFormat:@"http://inside.miraitoarumachi.com/articles/%@.json",
                     _articleIDTextField.text];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSData *json = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingAllowFragments error:nil];
    _titleTextField.text = [array valueForKeyPath:@"title"];
    _categoryTextField.text = [array valueForKeyPath:@"category"];
    _contentTextView.text = [array valueForKeyPath:@"content"];
}

- (IBAction)putButton:(UIButton *)sender {
    NSLog(@"\nTitle: %@\nCategory: %@\nContent: %@",
          _titleTextField.text,
          _categoryTextField.text,
          _contentTextView.text);
    NSString *post = [NSString stringWithFormat:@"{\"title\":\"%@\",\"category\":\"%@\",\"content\":\"%@\"}",
                      _titleTextField.text, _categoryTextField.text, _contentTextView.text];
    post = [post stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"\nSending data:\n%@", [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding]);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[[NSString alloc] initWithFormat:@"http://inside.miraitoarumachi.com/articles/%@.json", _articleIDTextField.text]]];
    [request setHTTPMethod:@"PUT"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSLog(@"%@", [request allHTTPHeaderFields]);
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(conn) {
        NSLog(@"Submit Successful");
    } else {
        NSLog(@"Submit could not be made");
    }

}

- (IBAction)pukeButton:(UIButton *)sender {
    NSString *post = [NSString stringWithFormat:@"{\"content\":\"%@\"}", _pukeTextField.text];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"\nSending data:\n%@", [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding]);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://inside.miraitoarumachi.com/tweets.json"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSLog(@"%@", [request allHTTPHeaderFields]);
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(conn) {
        NSLog(@"Puke Successful");
        _pukeTextField.text = @"";
    } else {
        NSLog(@"Puke could not be made");
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_titleTextField resignFirstResponder];
    [_categoryTextField resignFirstResponder];
    [_articleIDTextField resignFirstResponder];
    [_pukeTextField resignFirstResponder];
    return YES;
}

-(void)closeKeyboard:(id)sender{
    [_contentTextView resignFirstResponder];
}
@end
