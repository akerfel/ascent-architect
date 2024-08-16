// In this file, all global variables and declared and initialized,
// and the draw() method is defined, which is called 60 times per second.

// Cheats
boolean onlySpawnLongPieces;

// Settings
int timeIntervalFlag;
int gridWidth;
int gridHeight;
color backgroundColor;
color gridBackgroundColor;
int playerWidth;
int playerHeight;

// Dynamic BUILDING variables
int lastTimeCheck;
Grid grid;
Piece currentPiece;
Piece heldPiece;
boolean canHoldPiece;
boolean gameOver;
GameState gameState;

// Dynamic CLIMBING variables
Player player;
ArrayList<Wall> walls;

// This function is called once, at startup.
void setup() {
    // Cheats
    onlySpawnLongPieces = false;

    // Settings
    timeIntervalFlag = 500;
    gridWidth = 60;
    gridHeight = 32;
    backgroundColor = color(0);
    gridBackgroundColor = color(135, 206, 235);

    fullScreen();

    // Dynamic CLIMBING variables
    lastTimeCheck = millis();
    grid = new Grid();
    currentPiece = createRandomPiece();
    currentPiece.fillBlocks();
    heldPiece = null;
    canHoldPiece = true;
    gameOver = false;
    gameState = GameState.BUILDING;
    
    // Dynamic CLIMBING variables
    player = new Player(50, height * 1/2);
}

// This function is called ~60 times per second.
void draw() {
    if (gameState == GameState.BUILDING) {
        updateBuildingGameStateIfTimerReady();
    }
    else if (gameState == GameState.CLIMBING) {
        updateClimbingGameState();
    }
    drawEverything();
}
