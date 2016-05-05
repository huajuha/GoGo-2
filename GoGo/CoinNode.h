//
//  CoinNode.h
//  GoGo
//
//  Created by 冯斌 on 16/4/11.
//  Copyright © 2016年 王振西. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "physicsCategories.h"
#import "SKNode+receiveAttack.h"

@interface CoinNode : SKNode

//@property(strong,nonatomic)NSMutableArray *coinList;
-(instancetype)initWithShape:(NSInteger)shape Length:(NSUInteger)length;
//@property(strong,nonatomic)SKSpriteNode *Sprite;
//-(void)setCharacterWithNum :(NSUInteger) characterNum;
@end
