//
//  ViewController.m
//  CoreAnmationAndCore
//
//  Created by caoshuaikun on 16/3/23.
//  Copyright © 2016年 wuxiwenyan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self pianyi];
    [self xuanzhuan];
//    [self danrudanchu];
//    [self customView];
//    [self animationOf];
//    [self animationOfUIKit];
//    [self animationOfBlock];
//    [self animationOfCABasicAnimation];
//    [self animationOfCAKeyframeAnimation];
//    [self animationOfCAKeyframeAnimationPath];
    
}

- (void)customView{

    UIView *myView =[[UIView alloc]initWithFrame:CGRectMake(100, 100, 50, 50)];
    myView.backgroundColor = [UIColor redColor];
    [self.view addSubview:myView];
  //  return myView;
}

//普通动画
- (void)animationOf{

    UIView *myView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    myView.backgroundColor = [UIColor redColor];
    [self.view addSubview:myView];
    
    //设置动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2.0];
    //中间的内容就是一个动画
    myView.frame = CGRectMake(100, 100, 200, 200);
    myView.backgroundColor = [UIColor blueColor];
    myView.alpha = 0.5;
    //动画结束
    [UIView commitAnimations];


}

//动画偏移
- (void)pianyi{

    UIView *myView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    myView.backgroundColor = [UIColor redColor];
    [self.view addSubview:myView];
    
    [UIView beginAnimations:@"move" context:nil];
    [UIView setAnimationDuration:2.0];
    [UIView setAnimationDelegate:self];
    
    myView.frame = CGRectMake(200, 200, 200, 200);
    
    [UIView commitAnimations];
    
}

//淡入淡出动画
- (void)danrudanchu{
    
    UIView *myView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    myView.backgroundColor = [UIColor redColor];
    [self.view addSubview:myView];
    
    //开始动画
    [UIView beginAnimations:@"doflip" context:nil];
    //设置时常
    [UIView setAnimationDuration:1];
    //设置动画淡入淡出
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    //设置代理
    [UIView setAnimationDelegate:self];
    //设置翻转方向
    [UIView setAnimationTransition:
     UIViewAnimationTransitionFlipFromLeft  forView:myView cache:YES];
    //动画结束
    [UIView commitAnimations];

}
//旋转动画
- (void)xuanzhuan{

    UIView *myView =[[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    myView.backgroundColor = [UIColor redColor];
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
    lable.text = @"帅坤";
    lable.textColor = [UIColor whiteColor];
    [myView addSubview:lable];
    
    [self.view addSubview:myView];
    
    //创建一个CGAffineTransform  transform对象
    
    //旋转view
    //CGAffineTransform transform = CGAffineTransformRotate(myView.transform, M_PI/3);
    //缩放或者放大view 一中心为坐标点
    //CGAffineTransform transform = CGAffineTransformScale(myView.transform, 2, 2);
    
    //取反
    CGAffineTransform transform = CGAffineTransformInvert(myView.transform);
    
    [UIView beginAnimations:@"Invert" context:nil];
    [UIView setAnimationDuration:6.0];
    [UIView setAnimationDelegate:self];
    [myView setTransform:transform];
    [UIView commitAnimations];
    
}

-(void)animationOfUIKit
{
    UIView *redView=[[UIView alloc]initWithFrame:CGRectMake(10, 10, 100, 100)];
    redView.backgroundColor=[UIColor redColor];
    [self.view addSubview:redView];
    
    
    //开始动画
    [UIView beginAnimations:@"test" context:nil];
    //动画时长
    [UIView setAnimationDuration:1];
    /*
     *要进行动画设置的地方
     */
    
    redView.backgroundColor=[UIColor blueColor];
    redView.frame=CGRectMake(50, 50, 200, 200);
    redView.alpha=0.5;
    
    
    //动画结束
    [UIView commitAnimations];
}
//
//2、通过代码块使用UIKit动画
//[plain] view plaincopy
-(void)animationOfBlock
{
    //初始化一个View，用来显示动画
    UIView *redView=[[UIView alloc]initWithFrame:CGRectMake(10, 10, 100, 100)];
    redView.backgroundColor=[UIColor redColor];
    
    [self.view addSubview:redView];
    
    [UIView animateWithDuration:1 //时长
                          delay:0 //延迟时间
                        options:UIViewAnimationOptionTransitionFlipFromLeft//动画效果
                     animations:^{
                         
                         //动画设置区域
                         redView.backgroundColor=[UIColor blueColor];
                         redView.frame=CGRectMake(50, 50, 200, 200);
                         redView.alpha=0.5;
                         
                     } completion:^(BOOL finish){
                         //动画结束时调用
                         //............
                     }];
    
    
}

//使用Core Animation对象来实现动画
//
//在Core Animation中我们经常使用的是
//CABasicAnimation
//CAKeyframeAnimation
//CATransitionAnimation
//其中CABasicAnimation和CAKeyframeAnimation是对图层中的不同属性进行动画的。
//如果要多整个图层进行动画，则应该使用CATransitionAnimation
//如果要使用组合动画，例如要改变图层的大小和透明度，则可以先为每个属性创建一个CABasicAnimation对象，再把他们组合到CAAnimationGroup中，最后把这个组合添加到要进行动画的CALayer中。
//注：CAAnimation（以及CAAnimation的子类）,全部都是显式动画，这样动画播放后，表现层回恢复到模型层的原始状态，这就意味着，如果动画播放完后，会恢复到原来的样子，所以在动画播放完后要对模型层进行修改，例如：self.view.layer.backgroundColor=[UIColor blueColor].CGColor;
//1、自定义动画：CABasicAnimation
//[plain] view plaincopy
-(void)animationOfCABasicAnimation
{
    //创建一个CABasicAnimation对象
    CABasicAnimation *animation=[CABasicAnimation animation];
    //设置颜色
    animation.toValue=(id)[UIColor redColor].CGColor;
    //动画时间
    animation.duration=1;
    //是否反转变为原来的属性值
    animation.autoreverses=YES;
    //把animation添加到图层的layer中，便可以播放动画了。forKey指定要应用此动画的属性
    [self.view.layer addAnimation:animation forKey:@"backgroundColor"];
    
}
//
//2、关键帧动画：CAKeyframeAnimation
//1. path
//
//这是一个 CGPathRef  对象，默认是空的，当我们创建好CAKeyframeAnimation的实例的时候，可以通过制定一个自己定义的path来让  某一个物体按照这个路径进行动画。这个值默认是nil  当其被设定的时候  values  这个属性就被覆盖
//
//2. values
//
//一个数组，提供了一组关键帧的值，  当使用path的 时候 values的值自动被忽略。
//
//下面是改变依次改变view的颜色
//[plain] view plaincopy
-(void)animationOfCAKeyframeAnimation
{
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animation];
    //设置属性值
    animation.values=[NSArray arrayWithObjects:
                      (id)self.view.backgroundColor,
                      (id)[UIColor yellowColor].CGColor,
                      (id)[UIColor greenColor].CGColor,
                      (id)[UIColor blueColor].CGColor,nil];
    animation.duration=3;
    animation.autoreverses=YES;
    //把关键帧添加到layer中
    [self.view.layer addAnimation:animation forKey:@"backgroundColor"];
}


//3、使用路径制作动画：CAKeyframeAnimation
//[plain] view plaincopy
-(void)animationOfCAKeyframeAnimationPath
{
    //初始化一个View，用来显示动画
    UIView *redView=[[UIView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    redView.backgroundColor=[UIColor redColor];
    
    [self.view addSubview:redView];
    
    CAKeyframeAnimation *ani=[CAKeyframeAnimation animation];
    //初始化路径
    CGMutablePathRef aPath=CGPathCreateMutable();
    //动画起始点
    CGPathMoveToPoint(aPath, nil, 20, 20);
    CGPathAddCurveToPoint(aPath, nil,
                          160, 30,//控制点
                          220, 220,//控制点
                          240, 380);//控制点
    
    ani.path=aPath;
    ani.duration=10;
    //设置为渐出
    ani.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    //自动旋转方向
    ani.rotationMode=@"auto";
    
    [redView.layer addAnimation:ani forKey:@"position"];
}
@end
