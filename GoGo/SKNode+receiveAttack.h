//
//  SKNode+receiveAttack.h
//  GoGo
//
//  Created by 冯斌 on 16/4/11.
//  Copyright © 2016年 王振西. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SKNode (receiveAttack)
-(void)receiveAttacker:(SKNode *)attacker contact:(SKPhysicsContact *)contact;
@end
