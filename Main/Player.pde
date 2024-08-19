public class Player {
    int x;
    int y;
    float vy;
    int w;    // widht
    int h;    // height
    int speed;
    boolean movingLeft;
    boolean movingRight;
    float gravity;
    float jumpSpeed;
    int maxJumpSlots = 1;
    int jumpSlots = maxJumpSlots;
    
    public Player(int x, int y) {
        this.x = x;
        this.y = y;
        w = playerLength;
        h = playerLength;
        speed = 3;
        movingLeft = false;
        movingRight = false;
        gravity = pixelsPerBlock * 0.01;
        jumpSpeed = pixelsPerBlock * 0.14;
    }  
    
    void update() {
        gameOverIfDiesByLava();
        if (xUpdate_and_checkIfWon()) {
            goToNextLevel();
            return;
        }
        if (yUpdate_and_checkIfWon()) {
            goToNextLevel();
            return;
        }
    }
    
    void gameOverIfDiesByLava() {
        if (getYinGrid() >= lava_getYinGrid()) {
            gameOver();    
        }
    }
    
    boolean isTouchingGoal() {
        return false;
    }
    
    boolean xUpdate_and_checkIfWon() {
        int xOld = x;
        
        // Change x
        if (movingLeft) {
            x -= speed;   
        }
        if (movingRight) {
            x += speed;
        } 
        
        // Check if won
        Wall wallPlayerIsInsideOf = getWallPlayerIsInsideOf();
        if (wallPlayerIsInsideOf != null) {
            if (wallPlayerIsInsideOf.isGoal) {
                return true;    
            }
        }
        
        // If didn't win and is inside wall, go back
        if (collidesWallNow()) {
            x = xOld;
        }
        return false;
    }
    
    boolean yUpdate_and_checkIfWon() {
        // Change y
        y += vy;
        vy += gravity;  
        
        return handleHorizontalWallCollision_and_checkIfWon();
    }
    
    boolean handleHorizontalWallCollision_and_checkIfWon() {
        Wall wallPlayerIsInsideOf = getWallPlayerIsInsideOf();
        if (wallPlayerIsInsideOf != null) {
            // Check if won. If not, just handle collisions normally.
            if (wallPlayerIsInsideOf.isGoal) {
                return true;    
            }
            if (vy > 0) {
                y = wallPlayerIsInsideOf.y - h; // player stands on block
                jumpSlots = maxJumpSlots;
            }
            else if (vy < 0) {
                y = wallPlayerIsInsideOf.y + wallPlayerIsInsideOf.h; // player is just below block
                jumpSlots = maxJumpSlots;
            }
            vy = 0;
        }
        return false;
    }
    
    int getXinGrid() {
        return int(x / pixelsPerBlock);
    }
    
    int getYinGrid() {
        return int(y / pixelsPerBlock);
    }
    
    Block getBlockOfPlayersUpperLeftCorner() {
        return grid.grid[getXinGrid()][getYinGrid()];
    }
    
    Wall getWallPlayerIsInsideOf() {
        for (Wall wall : walls) {
            if (x < wall.x + wall.w &&
               x + w > wall.x &&
               y < wall.y + wall.h &&
               y + h > wall.y) {
                   return wall;
            }
        }
        return null;
    }
    
    boolean collidesWallNow() {
        for (Wall wall : walls) {
            if (x < wall.x + wall.w &&
               x + w > wall.x &&
               y < wall.y + wall.h &&
               y + h > wall.y) {
                   return true;
            }
        }
        return false;
    }
    
    boolean isOnGround() {
        int yCopy = y;
        yUpdate_and_checkIfWon();
        return abs(y-yCopy) < 4;
    }
    
    void jump() {
        if (jumpSlots > 0) { 
            //jump1.play();
            //jump1.amp(0.2);
            vy = -jumpSpeed;  
            jumpSlots--;
        }  
    }
}
