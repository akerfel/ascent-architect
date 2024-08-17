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
        if (gameState == GameState.CLIMBING) {
            xUpdate();
            yUpdate();
        }
    }
    
    // Maybe make handleHorizontalWallCollision similar to handleVerticalWallCollision.
    void xUpdate() {
        int xOld = x;
        if (movingLeft) {
            x -= speed;   
        }
        if (movingRight) {
            x += speed;
        } 
        if (collidesWallNow()) {
            x = xOld;
        }
    }
    
    void yUpdate() {
        y += vy;
        vy += gravity;  
        handleVerticalWallCollision();
    }
    
    void handleVerticalWallCollision() {
        Wall wallPlayerIsInsideOf = getWallPlayerIsInsideOf();
        if (wallPlayerIsInsideOf != null) {
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
        yUpdate();
        return abs(y-yCopy) < 4;
    }
    
    void jump() {
        if (jumpSlots > 0) { 
            vy = -jumpSpeed;  
            jumpSlots--;
        }  
    }
}
