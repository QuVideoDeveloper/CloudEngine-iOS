//
//  LYFPhotoManger.m
//  LYFAlbum
//
//  Created by 李玉枫 on 2018/12/6.
//  Copyright © 2018 李玉枫. All rights reserved.
//

#import "QVPhotoManger.h"
#import "QVPhotoModel.h"

@implementation QVPhotoManger

+(QVPhotoManger*)standardPhotoManger {
    static QVPhotoManger *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[QVPhotoManger alloc] init];
    });
    
    return manager;
}

#pragma mark - Set方法
-(void)setMaxCount:(NSInteger)maxCount {
    _maxCount = maxCount;
    
    self.photoModelList = [NSMutableArray array];
    self.choiceCount = 0;
}

-(void)setChoiceCount:(NSInteger)choiceCount {
    _choiceCount = choiceCount;
    
    if (self.choiceCountChange) {
        self.choiceCountChange(choiceCount);
    }
}

@end
