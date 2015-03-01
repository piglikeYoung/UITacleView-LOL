//
//  ViewController.m
//  英雄展示
//
//  Created by piglikeyoung on 15/2/28.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "ViewController.h"
#import "JHHero.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong , nonatomic) NSArray *heros;

@end

@implementation ViewController

-(NSArray *)heros{
    
    if (!_heros) {
        // 1.获得全路径
        NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"heros" ofType:@"plist"];
        
        // 2.根据全路径加载数据
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:fullPath];
        
        // 3.字典转模型
        NSMutableArray *models = [NSMutableArray arrayWithCapacity:dictArray.count];
        
        for (NSDictionary *dict in dictArray) {
            JHHero *hero = [JHHero heroWithDict:dict];
            [models addObject:hero];
        }
        
        // 4.赋值数据
        _heros = [models copy];
    }
    
    return _heros;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置Cell的高度
    // 当每一行的cell高度一致的时候使用属性设置cell的高度
    self.tableView.rowHeight = 60;
    self.tableView.delegate = self;
}

/** 返回多少组 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/** 返回一组有多少行 */
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.heros.count;
}

/** 返回哪一组的哪一行显示什么内容 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建cell
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    
    // 2.设置数据
    // 2.1取出对应行的模型
    JHHero *hero = self.heros[indexPath.row];
    // 2.2赋值对应的数据
    cell.textLabel.text = hero.name;
    cell.detailTextLabel.text = hero.intro;
    cell.imageView.image = [UIImage imageNamed:hero.icon];
    
    // 2.3设置cell的辅助视图
    if (1==indexPath.row) {
        cell.accessoryView = [[UISwitch alloc] init];
    }else{
        cell.accessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
    }
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // 2.4设置cell的背景颜色
    // 通过backgroundColor 和 backgroundView 都可以设置cell的背景颜色
    // 但是backgroundview 的优先级比 backgroundColor的 高
    // 所以同时设置了backgroundColor和backgroundview，backgroundview会盖住backgroundColor
    
    // 设置默认状态背景
//    UIView *view = [[UIView alloc] init];
//    view.backgroundColor = [UIColor blueColor];
//    cell.backgroundView = view;
//    
//    cell.backgroundColor = [UIColor redColor];
    
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"buttondelete"]];
    
    cell.backgroundView = iv;
    
    // 设置选中背景颜色
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor purpleColor];
    cell.selectedBackgroundView =view2;
    
    // 3.返回cell
    return cell;
}

#pragma mark - UITableViewDelegate
// 当每一行的cell的高度不一致的时候就使用代理方法设置cell的高度
//-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (1 == indexPath.row) {
//        return 180;
//    }
//    
//    return 44;
//}

#pragma mark - 控制状态栏是否显示
/**
 *   返回YES代表隐藏状态栏, NO相反
 */
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
