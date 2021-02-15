# Lab 1 CIU - Pong game

This lab consists in the implementation of the classic pong game using Processing.

Author - Pablo Ortigosa

## Implementation

There are 3 files, a main class (pr1.pde) which is both the view and the controller, and 2 objects classes which are the model, these are ball.pde and paddle.pde. Inside pr1.pde the loop (draw) function has 4 parts:
* gifMethod() which, if it is the match point, records each frame before they update.
* logic() which updates the information of the score and the positions of each element, it also checks for the ball collisions.
* show() this is the view method, it displays each thing on the screen.
* finishRecord() this method finishes the recording of the gif and plays a sound when a player wins the match.

## Choices

There are some bugs I haven't fixed, the way the paddles work is not great, I didn't fully understand how the methods surrounding keyboard inputs work, so I wasn't able to fix it,  the same can be said about the score not being centered. Aside from that the project was very straight forward.

## References

The notes uploaded in the virtual classroom made by the teachers - Modesto and Daniel

## 

![Gif showing how it works](https://github.com/PabloOQ/pr1-CIU/blob/main/winner.gif)
