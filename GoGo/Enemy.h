//
//  Enemy.h
//  GoGo
//
//  Created by 冯斌 on 16/4/11.
//  Copyright © 2016年 王振西. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "physicsCategories.h"
#import "SKNode+receiveAttack.h"

@interface Enemy : SKNode


-(instancetype)initWithType:(NSUInteger)type StageType:(NSInteger)stageType  andLength:(NSUInteger)length;
//@property(strong,nonatomic)SKSpriteNode *Sprite;
//
//-(void)setCharacterWithNum :(NSUInteger) characterNum;

@end
