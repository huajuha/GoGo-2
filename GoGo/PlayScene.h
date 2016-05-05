//
//  PlayScene.h
//  GoGo
//
//  Created by 王振西 on 16/2/28.
//  Copyright © 2016年 王振西. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "physicsCategories.h"
#import "Enemy.h"
#import "CoinNode.h"
#import "SKNode+receiveAttack.h"
#import "Hero.h"

@interface PlayScene:SKScene<SKPhysicsContactDelegate>
//laaaaaaaaaaa
//afjdafjdjfjalf
@property NSInteger stagecounts;
@property CGPoint stagepoint ;
@property(strong,nonatomic)Hero *hero;
@property(strong,nonatomic)SKNode *enemy;
@property(strong,nonatomic)SKNode *coins;
@property(nonatomic)NSInteger score;//纪录当前分数
@property(strong,nonatomic)SKLabelNode *scoreLabel;//显示分数的标签
@property(strong,nonatomic)SKSpriteNode *slowNode;
@property(strong,nonatomic)SKSpriteNode *speedupNode;

@property(nonatomic)NSInteger coinsCount;//纪录金币数
@property(strong,nonatomic)SKLabelNode *coinsLabel;//显示分数的标签

@property(nonatomic)NSTimeInterval lastUpdateTime;
@property(nonatomic)NSTimeInterval dt;
@property(nonatomic)NSTimeInterval whenAddDefend;
@property(nonatomic)int backgroundSpeed;//游戏移动速度
@property(assign,nonatomic)BOOL isJumping;
@property(assign,nonatomic)BOOL heroShouldDefend;

@property(nonatomic)float nextStagePostion;
@property(nonatomic)int stagetype;

@property(strong,nonatomic)SKSpriteNode *defendNode;
@property(strong,nonatomic)SKLabelNode *defendLabel;
@property(nonatomic)NSUInteger defendNumber;

@end