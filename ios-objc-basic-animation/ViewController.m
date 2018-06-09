//
//  ViewController.m
//  ios-objc-basic-animation
//
//  Created by Manami Ichikawa on 2017/11/19.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSNotificationCenter *noticication = [NSNotificationCenter defaultCenter];
    [noticication addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [noticication addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
   
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
        NSNotificationCenter *noticication = [NSNotificationCenter defaultCenter];
        [noticication removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        [noticication removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
}


-(void)keyboardWillShow:(NSNotification *)notification{
    
    //キーボードの高さを取得
    CGRect rect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    
    //キーボードが表示される時間取得
    NSTimeInterval duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        //高さの平行移動する位置
        //rect.size.height = 271
        //self.view.frame.size.height = 736
        //self.textField.frame.origin.y = 490
        //self.textField.frame.size.height = 245
        CGAffineTransform transform = CGAffineTransformMakeTranslation(0, -(rect.size.height-(self.view.frame.size.height - self.textField.frame.origin.y - 50)));
        self.view.transform = transform;
    } completion:NULL];
    

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // キーボード：消す
    [self.view endEditing:YES];
    
}

-(void)keyboardWillHide:(NSNotification *)notification{
    
    NSTimeInterval duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        //初期状態に戻す
        self.view.transform = CGAffineTransformIdentity;
    } completion:NULL];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
