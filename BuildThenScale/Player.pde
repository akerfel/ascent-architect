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
    boolean hasPrintedOnce = false;
    
    public Player(int x, int y) {
        this.x = x;
        this.y = y;
        w = 15;
        h = 15;
        speed = 3;
        movingLeft = false;
        movingRight = false;
        gravity = 0.3;
        jumpSpeed = 3;
    }  
    void update() {
        xUpdate();
        yUpdate();
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
            }
            else if (vy < 0) {
                y = wallPlayerIsInsideOf.y + wallPlayerIsInsideOf.h; // player is just below block
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
        if (isOnGround()) {
            vy = -jumpSpeed;  
        }  
    }
}
