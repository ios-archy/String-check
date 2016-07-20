//
//  ViewController.m
//  字符串校验。。。。
//
//  Created by archy on 16/7/20.
//  Copyright © 2016年 archy. All rights reserved.
//

#import "ViewController.h"
#import "NewTextfIed.h"
@interface ViewController ()<UITextFieldDelegate>
{
    NSTimer *mytimer;
}
@property (nonatomic,strong)NewTextfIed *contentfiled;

@property (nonatomic,strong)UIButton *sendnews;


@property (nonatomic,strong)NSMutableArray *Array;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.contentfiled];
    [self.view addSubview:self.sendnews];
}
-(NSMutableArray *)Array
{
    if (!_Array) {
        _Array =[[NSMutableArray alloc]init];
    }
    return _Array;
}
-(UITextField *)contentfiled
{
    if (!_contentfiled) {
        _contentfiled =[[NewTextfIed alloc]initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, 50)];
        _contentfiled.delegate =self;
        _contentfiled.returnKeyType = UIReturnKeySend;
        _contentfiled.placeholder =@"请输入您的消息！！！";
        _contentfiled.backgroundColor =[UIColor greenColor];
    }
    return _contentfiled;
}
-(UIButton *)sendnews
{
    if (!_sendnews) {
        _sendnews =[[UIButton alloc]initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 30)];
        _sendnews.backgroundColor =[UIColor redColor];
        [_sendnews setTitle:@"发送消息" forState:UIControlStateNormal];
        [_sendnews addTarget:self action:@selector(sendnewsClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendnews;
}
-(void)sendnewsClick:(UIButton *)sender
{
    if(self.contentfiled.text.length>10 && self.Array.count==0)
    {
        //第一次输入，开始定时器
        NSLog(@"//第一次输入，开始定时器");
        [self repeatTimer];
        [self.Array addObject:self.contentfiled.text];
        self.contentfiled.text =@"";
    }
    else if(self.contentfiled.text.length>10 &&self.Array.count >0)
    {
        //当长度大于10，并且数组里有字符串时，进行校验
         NSLog(@"当长度大于10，并且数组里有字符串时，进行校验");
        for (int i =0; i <self.Array.count; i++) {
            NSString *str =self.Array[self.Array.count-i-1]; //用数组倒叙的方式遍历
            if ([self.contentfiled.text isEqualToString:str]) {
                //字符串相同，不给发送，并给出提示
                self.contentfiled.text =@""; //重置内容为空
                [self fail];
                NSLog(@"字符串相同，不给发送，并给出提示");
                break;
            }
        }
         //没有相同字符串的情况下将字符串加入数组，并发送消息
        NSLog(@"没有相同字符串的情况下将字符串加入数组，并发送消息");
        [self sendNews];
        [self.Array addObject:self.contentfiled.text];
        self.contentfiled.text =@"";
        [self repeatTimer];
     }
    else
    {
        NSLog(@"字符串小于10个");
        [self sendNews];
        self.contentfiled.text =@"";
        
    }
}
// 不能复制粘贴
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
  
    if (action == @selector(copy:) || action == @selector(paste:)) {
        return NO;
    }
    return [super canPerformAction:action withSender:sender];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(self.contentfiled.text.length>10 && self.Array.count==0)
    {
        //第一次输入，开始定时器
        NSLog(@"//第一次输入，开始定时器");
        [self repeatTimer];
        [self.Array addObject:self.contentfiled.text];
        self.contentfiled.text =@"";
    }
    else if(self.contentfiled.text.length>10 &&self.Array.count >0)
    {
        //当长度大于10，并且数组里有字符串时，进行校验
        NSLog(@"当长度大于10，并且数组里有字符串时，进行校验");
        for (int i =0; i <self.Array.count; i++) {
            NSString *str =self.Array[self.Array.count-i-1]; //用数组倒叙的方式遍历
            if ([self.contentfiled.text isEqualToString:str]) {
                //字符串相同，不给发送，并给出提示
                self.contentfiled.text =@""; //重置内容为空
                [self fail];
                NSLog(@"字符串相同，不给发送，并给出提示");
                return NO;
            }
        }
        //没有相同字符串的情况下将字符串加入数组，并发送消息
        NSLog(@"没有相同字符串的情况下将字符串加入数组，并发送消息");
        [self sendNews];
        [self.Array addObject:self.contentfiled.text];
        self.contentfiled.text =@"";
        [self repeatTimer];
    }
    else
    {
        NSLog(@"字符串小于10个");
        [self sendNews];
        self.contentfiled.text =@"";
        
    }
    return  YES;
}

//开启计时器
-(void)startTimer
{
    mytimer =[NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(clearArray) userInfo:nil repeats:NO];
}
//关闭计时器
-(void)endTimer
{
    [mytimer invalidate];
     mytimer = nil;
}
//重启计时器
-(void)repeatTimer
{
    [self endTimer];
    [self startTimer];
}
//清空数组
-(void)clearArray
{
    [self.Array removeAllObjects];
    NSLog(@"清空数组");
}
//发送消息
-(void)sendNews
{
    NSLog(@"成功");
}
//发送失败
-(void)fail
{
    NSLog(@"失败");
}
@end
