import gifAnimation.*;

// Cheats
boolean onlySpawnLongPieces;

// Settings
int pixelsPerBlock;
int gridWidth;
int gridHeight;
int playerLength;
int playerXstartPos;
int playerYstartPos;
int distancePiecesSpawnAbovePlayer;
int numBlocksVisibleBelowPlayer;

// Controls settings
boolean movePieceNoDelay = true;
int delayMovePieceLeftOrRight;
int delayMovePieceDown;

// The falling piece moves down one step per tick
int initialTickTime;
int minimumTickTime;
int decreaseInTickTimePerLevel;
int levelIncrementPerNumOfPieces;
int currentTickTime; // changes

// Lava
int lava_initialTickTime;
int lava_minimumTickTime;
int lava_decreaseInTickTimePerLevel;
int lava_levelIncrementPerNumOfPieces;
int lava_currentTickTime; // changes
int lava_millisUpdated;
int lava_initialLevelsBelowPlayer;
int lava_currentLevel;

// Dynamic CLIMBING variables
Player player;
ArrayList<Wall> walls;

// Dynamic BUILDING variables
int currentLevelNum;
int lastTimeCheck;
Grid grid;
Piece currentPiece;
Piece heldPiece;
boolean canHoldPiece;
boolean gameOver;
GameState gameState;

// Moving piece with input. Only used if movePieceNoDelay is true.
boolean movingPieceLeft;
boolean movingPieceRight;
boolean movingPieceDown;
int millisMovedPieceRight;
int millisMovedPieceLeft;
int millisMovedPieceDown;

// Colors
color backgroundColor;
color gridBackgroundColor;
color goalColor;

// score and highscore
int score;
PrintWriter output;
int piecesSpawned;

// Textures
PImage stoneTexture;
PImage lavaTexture;
PImage lavaTexture2;
PImage background1;
Gif lavaGif;
Gif lavaGif2;

// This function is called once, at startup.
void setup() {
    size(600, 1000);
    initializeState();
}

void initializeState() {
    // Cheats
    onlySpawnLongPieces = false;

    // Settings
    gridWidth = 14;
    gridHeight = 1000;
    pixelsPerBlock = width/gridWidth + 1;
    playerLength = pixelsPerBlock * 2/3;
    lava_initialLevelsBelowPlayer = 10;
    playerYstartPos = (gridHeight - lava_initialLevelsBelowPlayer + 1) * pixelsPerBlock - pixelsPerBlock/8;
    playerXstartPos = pixelsPerBlock * 2;
    distancePiecesSpawnAbovePlayer = 15;    
    numBlocksVisibleBelowPlayer = 9;
    
    // Controls settings
    delayMovePieceLeftOrRight = 80;
    delayMovePieceDown = 40;
    
    // Time per tick
    initialTickTime = 700;
    decreaseInTickTimePerLevel = 80;
    minimumTickTime = 100;
    levelIncrementPerNumOfPieces = 20;
    currentTickTime = initialTickTime;
    
    // Lava
    lava_initialTickTime = 3000;
    lava_minimumTickTime = 1400;
    lava_decreaseInTickTimePerLevel = 20;
    lava_currentTickTime = lava_initialTickTime;
    lava_millisUpdated = millis();
    lava_currentLevel = -1;
    
    // Colors
    backgroundColor = color(0);
    gridBackgroundColor = color(135, 206, 235);
    goalColor = color(203, 209, 25);
    
    // Texture
    stoneTexture = loadImage("stone.png");
    lavaTexture = loadImage("lava.png");
    lavaTexture2 = loadImage("lava2.png");
    background1 = loadImage("background1.png");
    lavaGif = new Gif(this, "animatedLava.gif");
    lavaGif.play();
    lavaGif2 = new Gif(this, "animatedLava2.gif");
    lavaGif2.play();
    
    // Dynamic CLIMBING variables
    player = new Player(0, 0);
    setPlayerToStartPos();
    
    // score and highscore
    score = 0;
    createDataFolderIfDoesNotExist();
    piecesSpawned = 1;
    
    // Dynamic BUILDING variables
    currentLevelNum = 0;
    grid = new Grid();
    //loadCurrentLevel();
    grid.initializeBlocks();
    lastTimeCheck = millis();
    currentPiece = createRandomPiece();
    currentPiece.fillBlocks_and_checkIfGAMEOVER();
    heldPiece = null;
    canHoldPiece = false;
    gameState = GameState.GAMEACTIVE;
    
    // Moving piece with input
    movingPieceLeft = false;
    movingPieceRight = false;
    movingPieceDown = false;
    millisMovedPieceRight = millis();
    millisMovedPieceLeft = millis();
    millisMovedPieceDown = millis();
}

void gameOver() {
    gameState = GameState.GAMEOVER;
    saveCurrentScore();  // will only save if actually is new highscore
}

void resetGame() {
    initializeState();
}

// This function is called ~60 times per second.
void draw() {
    switch(gameState) {
    case GAMEACTIVE:
        updateBuilding();
        updateClimbing();
        drawEverything();
        break;
    case GAMEOVER:
        drawGameOver();
        break;
    case STARTSCREEN:
        break;
    }
}
