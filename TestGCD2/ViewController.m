//
//  ViewController.m
//  TestGCD2
//
//  Created by admin on 15-1-19.
//  Copyright (c) 2015年 ___CC___. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
    
       [self test1];
    
      //[self test2];
    
      //[self test3];
    
      //[self test4];
}

//用异步函数往并发队列中添加任务
-(void)test1
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //添加任务到队列中，就可以执行任务
    //异步函数：具备开启新线程的能力
    dispatch_async(queue, ^{
        NSLog(@"下载图片1----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"下载图片2----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"下载图片3----%@",[NSThread currentThread]);
    });
    //主线程
    NSLog(@"主线程----%@",[NSThread mainThread]);
    //从打印结果上可以看出，在队列queue中有3个线程。开启了新的线程。
}


//用异步函数往串行队列中添加任务
-(void)test2
{
    //创建串行队列
    //第一个参数为串行队列的名称，是c语言的字符串
    //第二个参数为队列的属性，一般来说串行队列不需要赋值任何属性，所以通常传空值（NULL）
    dispatch_queue_t queue = dispatch_queue_create("helloCC", NULL);
    
    //添加任务到队列中执行
    dispatch_async(queue, ^{
        NSLog(@"串行队列下载图片1----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"串行队列下载图片2----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"串行队列下载图片3----%@",[NSThread currentThread]);
    });
    //主线程
        NSLog(@"主线程----%@",[NSThread mainThread]);
    
   
    
}


//用同步函数往并发队列中添加任务
-(void)test3
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_sync(queue, ^{
        NSLog(@"下载图片1----%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"下载图片2----%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"下载图片2----%@",[NSThread currentThread]);
    });
    //主线程
    NSLog(@"主线程----%@",[NSThread mainThread]);
    //结论：从打印结果查看，在同步函数中不会开启新的线程。并发队列失去来了并发功能。
    
    
    //在2秒之后执行block里面的时间
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"2秒到了");
    });
    
    
}


//用同步函数往串行队列中添加任务
-(void)test4
{
    
    dispatch_queue_t queue = dispatch_queue_create("helloCC2", NULL);
    
    dispatch_sync(queue, ^{
        NSLog(@"下载图片1----%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"下载图片2----%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"下载图片2----%@",[NSThread currentThread]);
    });
    
    //主线程
    NSLog(@"主线程----%@",[NSThread mainThread]);
    //结论：从打印结果查看，在同步函数中不会开启新的线程。
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
