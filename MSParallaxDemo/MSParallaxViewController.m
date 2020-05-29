//
//  MSParallaxViewController.m
//
//
//  Created by JZJ on 2019/5/29.
//  Copyright © 2019 JZJ. All rights reserved.
//

#import "MSParallaxViewController.h"
#import "MSParallaxHorizonFlowLayout.h"
#import "MSParallaxAnimationCell.h"

#import "MSParallaxCollectionViewBack.h"
#import "MSParallaxCollectionViewMiddle.h"
#import "MSParallaxCollectionViewFront.h"

//速度调整
static CGFloat const backSpeed    = 5;
static CGFloat const middleSpeed  = 10;
static CGFloat const frontSpeed   = 15;

@interface MSParallaxViewController ()<UICollectionViewDelegate,
                             UICollectionViewDataSource>

@property(nonatomic,strong) NSMutableArray *backDataArray;
@property(nonatomic,strong) NSMutableArray *middleDataArray;
@property(nonatomic,strong) NSMutableArray *frontArray;


@property (nonatomic,  strong) MSParallaxCollectionViewBack       *backCollectionView;
@property (nonatomic,  strong) MSParallaxCollectionViewMiddle *middleCollectionView;
@property (nonatomic,  strong) MSParallaxCollectionViewFront  *frontCollectionView;

@property (nonatomic,strong)NSTimer *timer;

@end

@implementation MSParallaxViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    //UI布局
    [self setupUI];
    
    //请求数据
    [self requestData];
        
}

//ui布局
-(void)setupUI{
    [self.view addSubview:self.backCollectionView];
    [self.view addSubview:self.middleCollectionView];
    [self.view addSubview:self.frontCollectionView];
}


//代理返回值
-(void)requestData{

    for (NSInteger i = 0; i<1000; i++) {
        [self.backDataArray   addObject:@"parallax_back"];
        [self.middleDataArray addObject:@"parallax_middle"];
        [self.frontArray      addObject:@"parallax_front"];
        if(i==1000-1){
            [self reloadData];
        }
    }
}


-(void)reloadData{
    
    [self.backCollectionView reloadData];
    self.middleCollectionView.dataArray = self.middleDataArray;
    [self.middleCollectionView reloadData];
    self.frontCollectionView.dataArray = self.frontArray;
    [self.frontCollectionView reloadData];
    [self.timer setFireDate:[NSDate date]];
}



#pragma mark --collectionViewDataSource

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.backDataArray.count;
}

- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString* url = self.backDataArray[indexPath.item];
    MSParallaxAnimationCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MSParallaxAnimationCell" forIndexPath:indexPath];
    cell.imageUrl = url;
    cell.contentView.backgroundColor = [UIColor clearColor];
    return cell;
}

#pragma mark --lazy


- (NSMutableArray *)backDataArray{
    if(!_backDataArray){
        _backDataArray = [NSMutableArray array];
    }
    return _backDataArray;
}

- (NSMutableArray *)middleDataArray{
    if(!_middleDataArray){
        _middleDataArray = [NSMutableArray array];
    }
    return _middleDataArray;
}

- (NSMutableArray *)frontArray{
    if(!_frontArray){
        _frontArray = [NSMutableArray array];
    }
    return _frontArray;
}



- (UICollectionView *)backCollectionView{
    if (!_backCollectionView) {

        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = [UIScreen mainScreen].bounds.size.height;

        MSParallaxHorizonFlowLayout *layout = [[MSParallaxHorizonFlowLayout alloc] init];
        CGFloat W = width;
        CGFloat H = height;
        layout.scrollDirection = 1; //左右滚动
        layout.size = CGSizeMake(W, H);
        layout.columnSpacing = 0;
        layout.rowSpacing = 2;
        layout.row = 1;
        layout.column = 1;
        layout.showLastPageFull = NO; // 不完全展示最后一页
        layout.pageWidth = width;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        _backCollectionView = [[MSParallaxCollectionViewBack alloc] initWithFrame:CGRectMake(0, 0, layout.collectionViewSize.width, layout.collectionViewSize.height) collectionViewLayout:layout];
        _backCollectionView.delegate = self;
        _backCollectionView.dataSource = self;
        _backCollectionView.showsHorizontalScrollIndicator = NO;
        _backCollectionView.pagingEnabled = YES;
        [_backCollectionView registerClass:[MSParallaxAnimationCell class] forCellWithReuseIdentifier:@"MSParallaxAnimationCell"];
        _backCollectionView.backgroundColor = [UIColor clearColor];
        _backCollectionView.frame = self.view.bounds;
        _backCollectionView.pagingEnabled = NO;
        _backCollectionView.userInteractionEnabled = NO;

    }
    return _backCollectionView;
}


- (MSParallaxCollectionViewMiddle *)middleCollectionView{
    if (!_middleCollectionView) {
        
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = [UIScreen mainScreen].bounds.size.height;

        MSParallaxHorizonFlowLayout *layout = [[MSParallaxHorizonFlowLayout  alloc] init];
        CGFloat W = width;
        CGFloat H = height*0.6;
        layout.scrollDirection = 1; //左右滚动
        layout.size = CGSizeMake(W, H);
        layout.columnSpacing = 0;
        layout.rowSpacing = 2;
        layout.row = 1;
        layout.column = 4;
        layout.showLastPageFull = NO; // 不完全展示最后一页
        layout.pageWidth = width;

        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);

        _middleCollectionView = [[MSParallaxCollectionViewMiddle alloc] initWithFrame:CGRectMake(0, 100, layout.collectionViewSize.width, layout.collectionViewSize.height) collectionViewLayout:layout];
        _middleCollectionView.delegate = _middleCollectionView;
        _middleCollectionView.dataSource = _middleCollectionView;
        _middleCollectionView.showsHorizontalScrollIndicator = NO;
        _middleCollectionView.pagingEnabled = YES;
        [_middleCollectionView registerClass:[MSParallaxAnimationCell class] forCellWithReuseIdentifier:@"MSParallaxAnimationCell"];
        _middleCollectionView.backgroundColor = [UIColor clearColor];
        _middleCollectionView.frame = CGRectMake(0, height-H, self.view.bounds.size.width, H);
        _middleCollectionView.pagingEnabled = NO;
        _middleCollectionView.userInteractionEnabled = NO;

    }
    return _middleCollectionView;
}




- (MSParallaxCollectionViewFront *)frontCollectionView{
    if (!_frontCollectionView) {
        
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = [UIScreen mainScreen].bounds.size.height;

        MSParallaxHorizonFlowLayout *layout = [[MSParallaxHorizonFlowLayout alloc] init];
        CGFloat W = width;
        CGFloat H = height;
        layout.scrollDirection = 1; //左右滚动
        layout.size = CGSizeMake(W, H);
        layout.columnSpacing = 0;
        layout.rowSpacing = 2;
        layout.row = 3;
        layout.column = 4;
        layout.showLastPageFull = NO; // 不完全展示最后一页
        layout.pageWidth = width;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);

        _frontCollectionView = [[MSParallaxCollectionViewFront alloc] initWithFrame:CGRectMake(0, 100, layout.collectionViewSize.width, layout.collectionViewSize.height) collectionViewLayout:layout];
        _frontCollectionView.delegate = _frontCollectionView;
        _frontCollectionView.dataSource = _frontCollectionView;
        _frontCollectionView.frame = self.view.bounds;
        _frontCollectionView.showsHorizontalScrollIndicator = NO;
        _frontCollectionView.pagingEnabled = YES;
        [_frontCollectionView registerClass:[MSParallaxAnimationCell class] forCellWithReuseIdentifier:@"MSParallaxAnimationCell"];
        _frontCollectionView.backgroundColor = [UIColor clearColor];
        _frontCollectionView.pagingEnabled = NO;
        _frontCollectionView.userInteractionEnabled = NO;
    }
    return _frontCollectionView;
}

- (NSTimer *)timer{
    if(!_timer){
      _timer =  [NSTimer timerWithTimeInterval:1/20.0 target:self selector:@selector(backTimer) userInfo:nil repeats:YES];
      [_timer setFireDate:[NSDate distantFuture]];
      [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];

    }
   return _timer;
}

-(void)destroyTimer{

    [self.timer invalidate];
}

//速度调整
- (void)backTimer{
        self.backCollectionView.contentOffset = CGPointMake(self.backCollectionView.contentOffset.x+backSpeed, 0);
        
        self.middleCollectionView.contentOffset = CGPointMake(self.middleCollectionView.contentOffset.x+middleSpeed, 0);

        self.frontCollectionView.contentOffset = CGPointMake(self.frontCollectionView.contentOffset.x+frontSpeed, 0);
}

- (void)viewDidDisappear:(BOOL)animated{
    [self destroyTimer];
}

@end
