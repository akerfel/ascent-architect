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

// Dynamic variables
int lastTimeCheck;
Grid grid;
Piece currentPiece;
Piece heldPiece;
boolean canHoldPiece;
boolean gameOver;
GameState gameState;

// This function is called once, at startup.
void setup() {
    // Cheats
    onlySpawnLongPieces = false;

    // Settings
    timeIntervalFlag = 500;
    gridWidth = 60;
    gridHeight = 40;
    backgroundColor = color(0);
    gridBackgroundColor = color(200);

    // Dynamic variables
    size(800, 800);
    lastTimeCheck = millis();
    grid = new Grid();
    currentPiece = createRandomPiece();
    currentPiece.fillBlocks();
    heldPiece = null;
    canHoldPiece = true;
    gameOver = false;
    gameState = GameState.BUILDING;
}

// This function is called ~60 times per second.
void draw() {
    if (gameState == GameState.BUILDING) {
        updateGameStateIfTimerReady();
    }
    else if (gameState == GameState.CLIMBING) {
        
    }
    drawEverything();
}
