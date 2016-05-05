//
//  Enemy.m
//  GoGo
//
//  Created by 冯斌 on 16/4/11.
//  Copyright © 2016年 王振西. All rights reserved.
//

#import "Enemy.h"
@interface Enemy ()
@property(copy, nonatomic) NSString *enemyImgName;
@end
@implementation Enemy
- (instancetype)initWithType:(NSUInteger)type
                   StageType:(NSInteger)stageType
                   andLength:(NSUInteger)length {
  if (self = [super init]) {
    _enemyImgName = [NSString stringWithFormat:@"enemy%d_%d", stageType, type];
    [self addEnemyWithLength:length];
  }
  return self;
}

- (void)addEnemyWithLength:(NSUInteger)length {
  int enemyNumber = length / 80;
  float x = 0;
  float y =40;
  SKTexture *texture = [SKTexture textureWithImageNamed:_enemyImgName];
  for (int i = 0; i < enemyNumber; i++) {
    x = 80 * i;
    SKSpriteNode *enemy = [SKSpriteNode spriteNodeWithTexture:texture];
    //        coin.size=CGSizeMake(50, 50);
    enemy.name = @"enemy";
    enemy.zPosition = 5;
    enemy.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:20];
    enemy.physicsBody.dynamic = NO;
    enemy.physicsBody.categoryBitMask = monsterCategory;
    enemy.position = CGPointMake(x, y);
    [self addChild:enemy];
  }
}

@end
