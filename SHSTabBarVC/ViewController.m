//
//  ViewController.m
//  SHSTabBarVC
//
//  Created by sunhaosheng on 15/10/12.
//  Copyright © 2015年 孙浩胜. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate> {
    NSInteger _selectedIndex;
    CGFloat _xOffset;
    BOOL _isClickItem;
}
@property (weak, nonatomic) IBOutlet UIButton *chatBtn;
@property (weak, nonatomic) IBOutlet UIButton *userBtn;
@property (weak, nonatomic) IBOutlet UIButton *contactBtn;
@property (weak, nonatomic) IBOutlet UIButton *discoveryBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *view_1;
@property (weak, nonatomic) IBOutlet UIView *view_2;
@property (weak, nonatomic) IBOutlet UIView *view_3;
@property (weak, nonatomic) IBOutlet UIView *view_4;

@property (copy,nonatomic) NSArray *items;

@property (strong,nonatomic) CALayer *chatBtnMask;
@property (strong,nonatomic) CALayer *userBtnMask;
@property (strong,nonatomic) CALayer *contactBtnMask;
@property (strong,nonatomic) CALayer *discoveryBtnMask;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _selectedIndex = 0;
    _xOffset = 0;
    _isClickItem = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.chatBtn.layer.mask = [self chatBtnMask];
    self.userBtn.layer.mask = [self userBtnMask];
    self.contactBtn.layer.mask = [self contactBtnMask];
    self.discoveryBtn.layer.mask = [self discoveryBtnMask];
    self.items = [NSArray arrayWithObjects:self.chatBtn,self.contactBtn,self.discoveryBtn,self.userBtn, nil];
    
    self.view_1.layer.shadowOffset = CGSizeMake(5, 0);
    self.view_2.layer.shadowOffset = CGSizeMake(5, 0);
    self.view_3.layer.shadowOffset = CGSizeMake(5, 0);
    self.view_4.layer.shadowOffset = CGSizeMake(5, 0);
    
//    self.view_1.layer.masksToBounds = YES;
//    self.view_2.layer.masksToBounds = YES;
//    self.view_3.layer.masksToBounds = YES;
//    self.view_4.layer.masksToBounds = YES;
    
    self.view_1.layer.shadowOpacity = 0.5f;
    self.view_2.layer.shadowOpacity = 0.5f;
    self.view_3.layer.shadowOpacity = 0.5f;
    self.view_4.layer.shadowOpacity = 0.5f;
    
    
}

- (CALayer *)chatBtnMask {
    if (!_chatBtnMask) {
        _chatBtnMask = [CALayer layer];
        _chatBtnMask.bounds = self.chatBtn.bounds;
        _chatBtnMask.opacity = 1;
        _chatBtnMask.anchorPoint = CGPointZero;
        _chatBtnMask.backgroundColor = [UIColor blueColor].CGColor;
    }
    return _chatBtnMask;
}

- (CALayer *)userBtnMask {
    if (!_userBtnMask) {
        _userBtnMask = [CALayer layer];
        _userBtnMask.bounds = self.userBtn.bounds;
        _userBtnMask.anchorPoint = CGPointZero;
        _userBtnMask.opacity = 0;
        _userBtnMask.backgroundColor = [UIColor blueColor].CGColor;
    }
    return _userBtnMask;
}

- (CALayer *)contactBtnMask {
    if (!_contactBtnMask) {
        _contactBtnMask = [CALayer layer];
        _contactBtnMask.bounds = self.contactBtn.bounds;
        _contactBtnMask.anchorPoint = CGPointZero;
        _contactBtnMask.opacity = 0;
        _contactBtnMask.backgroundColor = [UIColor blueColor].CGColor;
    }
    return _contactBtnMask;
}

- (CALayer *)discoveryBtnMask {
    if (!_discoveryBtnMask) {
        _discoveryBtnMask = [CALayer layer];
        _discoveryBtnMask.bounds = self.discoveryBtn.bounds;
        _discoveryBtnMask.anchorPoint = CGPointZero;
        _discoveryBtnMask.opacity = 0;
        _discoveryBtnMask.backgroundColor = [UIColor blueColor].CGColor;
    }
    return _discoveryBtnMask;
}

- (IBAction)btnClick:(UIButton *)sender {
    if (_selectedIndex != sender.tag - 1) {
        UIButton *selectedItem = self.items[_selectedIndex];
        _selectedIndex = sender.tag - 1;
        self.scrollView.delegate = nil;
        [self.scrollView setContentOffset:CGPointMake(_selectedIndex*self.scrollView.frame.size.width, 0) animated:NO];
        [UIView animateWithDuration:0.5 animations:^{
            selectedItem.layer.mask.opacity = 0;
            sender.layer.mask.opacity = 1;
        } completion:^(BOOL finished) {
            self.scrollView.delegate = self;
            _xOffset = self.scrollView.contentOffset.x;
        }];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float rate = (scrollView.contentOffset.x - _xOffset)/scrollView.frame.size.width;
    UIButton *sourceItem = self.items[_selectedIndex];
    UIButton *destinationItem = nil;
    if (rate > 0) {
        if (_selectedIndex == self.items.count - 1) {
            return;
        }
        destinationItem = self.items[_selectedIndex + 1];
    } else {
        if (_selectedIndex == 0) {
            return;
        }
        destinationItem = self.items[_selectedIndex - 1];
    }
    sourceItem.layer.mask.opacity = 1 - fabsf(rate) ;
    destinationItem.layer.mask.opacity = fabsf(rate);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [scrollView setContentOffset:CGPointMake(_xOffset, 0) animated:NO];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    _xOffset = targetContentOffset->x;
    float rate = _xOffset/scrollView.frame.size.width;
    _selectedIndex = rate;
}

@end
