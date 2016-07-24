//
//  MyTableViewCell.m
//  test
//
//  Created by Jeff on 5/21/16.
//  Copyright © 2016 Jeff. All rights reserved.
//

#import "MyTableViewCell.h"
#import "TestView.h"

@implementation MyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    TestView *testView = [[TestView alloc] initWithFrame:CGRectMake(10, 10, 300, 300)];
//    testView.backgroundColor = [UIColor lightGrayColor];
//    [self.contentView addSubview:testView];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
