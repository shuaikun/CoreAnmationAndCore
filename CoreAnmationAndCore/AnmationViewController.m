//
//  AnmationViewController.m
//  CoreAnmationAndCore
//
//  Created by 无锡文彦 on 16/3/24.
//  Copyright © 2016年 wuxiwenyan. All rights reserved.
//

#import "AnmationViewController.h"

@interface AnmationViewController ()
@property (nonatomic,strong) UIImageView *myImageView;
@end

@implementation AnmationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 220, 300)];
    [self.view addSubview:self.myImageView];
    self.myImageView.image = [UIImage imageNamed:@"1.jpg"];
}
//功能1 ：移动图片到右下角
- (IBAction)buttonClick:(id)sender {
    
    CGPoint fromPoint = self.myImageView.center;
    //路径曲线
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:fromPoint];
    CGPoint toPoint = CGPointMake(300, 460);
    [movePath addQuadCurveToPoint:toPoint controlPoint:CGPointMake(toPoint.x,fromPoint.y)];
    
    //关键帧
    CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnim.path = movePath.CGPath;
    moveAnim.removedOnCompletion = YES;
    
    //旋转变化
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    //x，y轴缩小到0.1,Z 轴不变
    scaleAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)];
    scaleAnim.removedOnCompletion = YES;
    
    //透明度变化
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"alpha"];
    opacityAnim.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnim.toValue = [NSNumber numberWithFloat:0.1];
    opacityAnim.removedOnCompletion = YES;
    
    //关键帧，旋转，透明度组合起来执行
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:moveAnim, scaleAnim,opacityAnim, nil];
    animGroup.duration = 1;
    [self.myImageView.layer addAnimation:animGroup forKey:nil];
}

//功能2 ：移动图片到右下角
//向右边旋转
- (IBAction)rightRotateBtnClick:(id)sender {
    //得到图片的中心
    CGPoint fromPoint = self.myImageView.center;
    
    //移动路径作为位移的路径
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:fromPoint];
    CGPoint toPoint = CGPointMake(fromPoint.x +100 , fromPoint.y) ;
    [movePath addLineToPoint:toPoint];
    //位移路径加上动画
    CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnim.path = movePath.CGPath;
    
    
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    
    //沿Z轴旋转
   // scaleAnim.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI,0,0,1)];
    
    //沿Y轴旋转
     scaleAnim.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI,0,1.0,0)];
    
    //沿X轴旋转
    // scaleAnim.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI,1.0,0,0)];
    scaleAnim.cumulative = YES;
    scaleAnim.duration =1;
    //旋转2遍，360度
    scaleAnim.repeatCount =2;
    self.myImageView.center = toPoint;
    scaleAnim.removedOnCompletion = YES;
    
    //动画加一起进行合作
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:moveAnim, scaleAnim, nil];
    animGroup.duration = 2;
    [self.myImageView.layer addAnimation:animGroup forKey:nil];
    
}

//功能3 ：图片旋转360度
//图片旋转360度
- (IBAction)rota360BtnClick:(id)sender {
    
    CABasicAnimation *animation = [CABasicAnimation
                                   animationWithKeyPath: @"transform" ];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    //围绕Z轴旋转，垂直与屏幕
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 0, 1.0) ];
    animation.duration = 1;
    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
    animation.cumulative = YES;
    animation.repeatCount = 2;
    
    //在图片边缘添加一个像素的透明区域，去图片锯齿
    CGRect imageRrect = CGRectMake(0, 0,self.myImageView.frame.size.width, self.myImageView.frame.size.height);
    UIGraphicsBeginImageContext(imageRrect.size);
    [self.myImageView.image drawInRect:CGRectMake(1,1,self.myImageView.frame.size.width-2,self.myImageView.frame.size.height-2)];
    self.myImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.myImageView.layer addAnimation:animation forKey:nil];
}


@end
