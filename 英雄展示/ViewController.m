//
//  ViewController.m
//  英雄展示
//
//  Created by piglikeyoung on 15/2/28.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "ViewController.h"
#import "JHHero.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>


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
    
    // 定义变量保存重用标记的值
    static NSString *identifier = @"hero";
    
    // 1.先去缓存池中查找是否有满足条件的Cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    // 2.如果缓冲池中没有符合条件的cell，就自己创建一个Cell
    if(cell == nil){
        // 3.创建Cell, 并且设置一个唯一的标记
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        
        NSLog(@"创建一个新的Cell");
    }
    
    // 4.给cell设置数据
    JHHero *hero = self.heros[indexPath.row];
    cell.textLabel.text = hero.name;
    cell.detailTextLabel.text = hero.intro;
    cell.imageView.image = [UIImage imageNamed:hero.icon];
    
    // 5.返回cell
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


/** 当某一行被选中的时候调用 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 0获得选中行的模型
    JHHero *hero = self.heros[indexPath.row];
    // 1.创建一个弹窗
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"修改数据" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    // 设置alert的样式, 让alert显示出uitextfield
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    // 获取alert中的textfield
    UITextField *textField = [alert textFieldAtIndex:0];
    // 设置数据到textfield
    textField.text = hero.name;
    // 2.显示窗口
    [alert show];
    
    // 通过alert的tag来传递选中的行号
    alert.tag = indexPath.row;
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (0 == buttonIndex) {
        return;
    }
    
    // 必定不是点击的取消
    // 获取修改后的数据
    UITextField *textField = [alertView textFieldAtIndex:0];
    NSString *newStr = textField.text;
    NSLog(@"newStr= %@",newStr);
    
    // 修改模型
    // 取出对应行的模型数据
    int row = alertView.tag;
    JHHero *hero = self.heros[row];
    hero.name = newStr;
    
    // 刷新指定行
    NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationRight];
}

#pragma mark - 控制状态栏是否显示
/**
 *   返回YES代表隐藏状态栏, NO相反
 */
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
