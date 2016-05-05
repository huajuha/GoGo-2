//
//  EndScene.m
//  GoGo
//
//  Created by 王振西 on 16/2/29.
//  Copyright © 2016年 王振西. All rights reserved.
//

#import "EndScene.h"
#import "PlayScene.h"
@interface EndScene()
@property BOOL contentCreated;
@end
//mmmmmmmmmmmmmmmmm
@implementation EndScene
-(void)didMoveToView:(SKView *)view {
    if(!self.contentCreated)
    {
        [self createSceneContents];
        self.contentCreated = YES;
    }
}
- (void)createSceneContents
{
    self.backgroundColor = [SKColor blackColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    ;
    [self addChild:[self newHelloNode]];
}
- (SKLabelNode *)newHelloNode
{
    SKLabelNode *helloNode = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    helloNode.text =@"失败了";
    helloNode.fontSize = 100;
    helloNode.name=@"helloNode";
    helloNode.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
    return helloNode;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    SKNode *helloNode = [self childNodeWithName:@"helloNode"];
    NSLog(@"before action");
    if(helloNode != nil)
    {
        helloNode.name = nil;
        SKAction *moveUp = [SKAction moveByX:0 y:100.0 duration:0.5];
        SKAction *zoom = [SKAction scaleTo:2.0 duration:0.25];
        SKAction *pause = [SKAction waitForDuration:0.5];
        SKAction *fadeAway = [SKAction fadeOutWithDuration:0.25];
        SKAction *remove = [SKAction removeFromParent];
        SKAction * moveSequence = [SKAction sequence:@[moveUp, zoom, pause, fadeAway,remove]];
        NSLog(@"have touched");
        /*[helloNode runAction:moveSequence];*/
        [helloNode runAction:moveSequence completion:^ {
            SKScene * playScene = [[PlayScene alloc] initWithSize:self.size];
            SKTransition *doors= [SKTransition doorsOpenVerticalWithDuration:0.5];
            [self.view presentScene:playScene transition:doors];
            
        }];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
