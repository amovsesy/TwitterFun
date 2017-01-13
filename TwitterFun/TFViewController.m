//
//  TFViewController.m
//  TwitterFun
//
//  Created by Aleksandr Movsesyan on 8/6/13.
//  Copyright (c) 2013 LinkedIn. All rights reserved.
//

#import "TFViewController.h"

@interface TFViewController () < UITableViewDataSource >
@property (weak, nonatomic) IBOutlet UITextField *twitterHandleTextField;
@property (weak, nonatomic) IBOutlet UIButton *goButton;
@property (weak, nonatomic) IBOutlet UITableView *tweetsTableView;
@property (strong, nonatomic) NSDictionary *tweets;

@end

@implementation TFViewController

- (void)viewDidLoad {
    self.tweets = @{@"user": @{}, @"tweets": @{}};
    [self.tweetsTableView setHidden: YES];
}

- (IBAction)onGoButtonTapped {
    NSString *handle = self.twitterHandleTextField.text;
    self.tweets = [self fetchTweetsWithTwitterHandle:handle];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tweets[@"tweets"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twitterCell" forIndexPath:indexPath];
    UILabel *label= (UILabel*)[cell viewWithTag:1111];
    label.text = @"hello world";
    return cell;
}

- (NSDictionary *)fetchTweetsWithTwitterHandle:(NSString *)twitterHandle {
    NSString *urlString = [NSString stringWithFormat:@"http://rblunden-md:3000/user/%@/timeline/", twitterHandle];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // You would never use a syncrhonous request in a real app, it's just more convenient for this demo
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:NULL error:NULL];
    // Null vs nil vs Nil - http://nshipster.com/nil/
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    return json;
}

@end
