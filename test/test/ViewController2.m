//
//  ViewController2.m
//  test
//
//  Created by Jeff on 5/15/16.
//  Copyright © 2016 Jeff. All rights reserved.
//

#import "ViewController2.h"
#import <EXTScope.h>
#import "TestView.h"
#import "MyTableViewCell.h"
#import <YYCache.h>
#import "Test.h"
#import <YYKit.h>

@interface ViewController2 () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) NSInteger a;
@property (nonatomic, copy) NSString *str;
@property (nonatomic, copy) void(^block)(void);
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ViewController2

- (void)dealloc
{
    NSLog(@"%@ dealloc dealloc dealloc dealloc dealloc", self.class);
}

- (void)setStr:(NSString *)str
{
    NSLog(@"1111111111111111111111111111111111111111111111111111111111111111");
    _str = str;
    NSLog(@"22222222222222222222222222222222222222222222222222222222222222");
}

- (IBAction)click:(id)sender {
    
    [self rotateScreen];
//    [[UIDevice currentDevice] setValue:UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) ? @(UIInterfaceOrientationPortrait) : @(UIInterfaceOrientationLandscapeRight) forKey:@"orientation"];
}

//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskAllButUpsideDown;
//}


//- (BOOL)shouldAutorotate {
//    NSLog(@"ViewController2 shouldAutorotate");
//    return YES;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    

//    NSMutableArray *arr = [NSMutableArray array];
//    for (int i = 0; i < 5; ++i)
//    {
//        Test *t = [Test new];
//        t.name = @(i).stringValue;
//        [arr addObject:t];
//    }
//    NSMutableArray *arr3 = arr.mutableCopy;
//    [arr3[0] setName:@"hehe"];
//    
//    NSMutableArray *arr4 = arr3.mutableCopy;
//    
//    id obj = arr4[0];
//    [arr4 removeObject:obj];
//    [arr4 insertObject:obj atIndex:3];
//    NSLog(@"arr %@, %p, %@, %p, arr4 %@", arr, arr, arr3, arr3, arr4);
    
//    NSArray *arr6 = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:arr]];
//    [arr6[0] setName:@"xixi"];
//    NSLog(@"arr6 %@, %p", arr6, arr6);
//    
//    NSArray *arr7 = [[NSArray alloc] initWithArray:arr copyItems:YES];
//    [arr7[0] setName:@"wawa"];
//    NSLog(@"arr7 %@, %p, %@", arr7, arr7, [[NSArray alloc] initWithArray:arr copyItems:YES]);

    
//    NSMutableArray *arr2 = @[].mutableCopy;
//    for (int i = 0; i < 5; ++i)
//    {
//        Test *t = [Test new];
//        t.name = [NSString stringWithFormat:@"hehe %d", i];
//        [arr2 addObject:t];
//    }
//    
//    [arr2 enumerateObjectsUsingBlock:^(Test * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [arr enumerateObjectsUsingBlock:^(Test * _Nonnull obj2, NSUInteger idx2, BOOL * _Nonnull stop) {
//            if (idx2 == idx) {
//                obj2.name = obj.name;
//            }
//        }];
//    }];
    
//    NSLog(@"arr %@, %@, %@, %@", [arr[0] name], [arr[1] name], [arr[2] name], [arr[3] name]);
//    NSLog(@"arr %@", arr);
//    
//    Test *tt = [Test new];
//    NSLog(@"tt %p", tt);
//    
//    NSArray *arr3 = [NSArray arrayWithObjects:arr[0], arr[1], arr[3], tt, nil];
//    NSMutableSet *set1 = [NSMutableSet setWithArray:arr3];
//    NSMutableSet *set2 = [NSMutableSet setWithArray:arr];
//    
//    [set1 intersectSet:set2];
//    NSLog(@"set %@", set1.allObjects);
    
//    [arr1 enumerateObjectsUsingBlock:^(Test * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        __block Test *obj2 = obj;
//        void(^blockA)() = ^(void) {
//            Test *tt = [Test new];
//            NSLog(@"tt %@", tt);
//            obj2 = tt;
//        };
//        blockA();
//        obj = [Test new];
//    }];

//    NSLog(@"arr1 %@", arr1);

//    self.str = @"1";
//    
//    [self addObserverBlockForKeyPath:@"str" block:^(id  _Nonnull obj, id  _Nullable oldVal, id  _Nullable newVal) {
//        NSLog(@"obj %@, oldVal %@, newVal %@", obj, oldVal, newVal);
//    }];
//    
////    self.str = @"2";
//    [self setStr:@"2"];

//    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
//    YYCache *cache = [YYCache cacheWithName:@"name1"];
//    [cache setObject:@[ @1 ] forKey:@"key1"];
//    
//    NSMutableArray *arr = [NSMutableArray array];
//    for (int i = 0; i < 999999; ++i)
//    {
//        [arr addObject:[Test new]];
//    }
//    [cache setObject:arr forKey:@"key2"];
//    
//    
//    NSLog(@"label %@", NSStringFromCGSize(_label.frame.size));
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSLog(@"22 label %@", NSStringFromCGSize(_label.frame.size));
//    });
//    
    [_tableView registerNib:[UINib nibWithNibName:@"MyTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyTableViewCell"];
    
//    @weakify(self)
//    _block = ^ {
//        @strongify(self)
//        self.a = 1;
//        NSLog(@"1111111111111111111111111111111111111111111111111111111111111111");
//    };
//    NSLog(@"_a %zd", _a);
//    _block();
//    
//    NSLog(@"222_a %zd", _a);
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTableViewCell"];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 400;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end





















































