//
//  RPCTableViewController.m
//  SmartDeviceLink-iOS
//
//  Created by WuLeilei on 17/1/23.
//  Copyright © 2017年 smartdevicelink. All rights reserved.
//

#import "RPCTableViewController.h"
#import "ProxyManager.h"

@interface RPCTableViewController ()
{
    NSArray *_dataArray;
    
    UIButton *_connectButton;
}
@end

@implementation RPCTableViewController

- (instancetype)init {
    if (self = [super init]) {
        self.title = @"RPC";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    
    _connectButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _connectButton.frame = CGRectMake(0, 0, 80, 44);
    [_connectButton setTitle:@"Connect" forState:UIControlStateNormal];
    [_connectButton addTarget:self action:@selector(connect) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_connectButton];
    
    _dataArray = @[@{@"rpcName": @"Show", @"className": @"ShowViewController"},
                   @{@"rpcName": @"Alert", @"className": @"AlertViewController"}];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    [[ProxyManager sharedManager] addObserver:self forKeyPath:NSStringFromSelector(@selector(state)) options:(NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew) context:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    @try {
        [[ProxyManager sharedManager] removeObserver:self forKeyPath:NSStringFromSelector(@selector(state))];
    } @catch (NSException __unused *exception) {}
}

- (void)goBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)connect {
    ProxyState state = [ProxyManager sharedManager].state;
    switch (state) {
        case ProxyStateStopped: {
            [[ProxyManager sharedManager] startUSBMUXD];
        } break;
        case ProxyStateSearchingForConnection: {
            [[ProxyManager sharedManager] reset];
        } break;
        case ProxyStateConnected: {
            [[ProxyManager sharedManager] reset];
        } break;
        default: break;
    }
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(state))]) {
        ProxyState newState = [change[NSKeyValueChangeNewKey] unsignedIntegerValue];
        [self proxyManagerDidChangeState:newState];
    }
}


#pragma mark - Private Methods

- (void)proxyManagerDidChangeState:(ProxyState)newState {
    NSString *newTitle = nil;
    NSString *title = nil;
    
    _connectButton.enabled = NO;
    
    switch (newState) {
        case ProxyStateStopped: {
            newTitle = @"ProxyStateStopped";
            title = @"Connect";
            _connectButton.enabled = YES;
        } break;
        case ProxyStateSearchingForConnection: {
            newTitle = @"ProxyStateSearchingForConnection";
            title = @"Searching";
        } break;
        case ProxyStateConnected: {
            newTitle = @"ProxyStateConnected";
            title = @"Connected";
        } break;
        default: break;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowLogNotification" object:newTitle];
    [_connectButton setTitle:title forState:UIControlStateNormal];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = [_dataArray objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [dic objectForKey:@"rpcName"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dic = [_dataArray objectAtIndex:indexPath.row];
    
    UIViewController *viewController = [[NSClassFromString([dic objectForKey:@"className"]) alloc] init];
    viewController.title = [dic objectForKey:@"rpcName"];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
