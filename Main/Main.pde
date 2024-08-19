import gifAnimation.*;
import processing.sound.*;

// Cheats
boolean onlySpawnLongPieces;

// Settings
String gameTitle;
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
Difficulty difficulty = Difficulty.MEDIUM;
int easy_lava_initialTickTime;
int medium_lava_initialTickTime;
int hard_lava_initialTickTime;
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

// Start menu
StartMenu startMenu;

// Block Textures
PImage stoneTexture;
PImage facade00;
PImage activeBlockTexture;

// Lava texture
PImage lavaTexture;
PImage lavaTexture2;
PImage background1;
Gif lavaGif;
Gif lavaGif2;

// Menu
PImage muteTexture;
PImage unmuteTexture;
PImage controlsTexture;

// Sound
boolean soundIsMuted;
SoundFile music1;
float musicFactor;
SoundFile jump1;
SoundFile crushed;


// This function is called once, at startup.
void setup() {
    size(600, 1000);
    gameState = GameState.STARTSCREEN;
    // Start menu
    startMenu = new StartMenu();
    soundIsMuted = false;
    musicFactor = 0.1;
    initializeState();
}

void initializeState() {
    // Cheats
    onlySpawnLongPieces = false;

    // Settings
    gameTitle = "Ascent Architect";
    gridWidth = 14;
    gridHeight = 1000;
    pixelsPerBlock = width/gridWidth + 1;
    println(pixelsPerBlock);
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
    initialTickTime = 500;
    decreaseInTickTimePerLevel = 80;
    minimumTickTime = 200;
    levelIncrementPerNumOfPieces = 20;
    currentTickTime = initialTickTime;
    
    // Lava difficulty
    easy_lava_initialTickTime = 12000;
    medium_lava_initialTickTime = 5000;
    hard_lava_initialTickTime = 2500;
    
    // Lava dynamic variables
    lava_minimumTickTime = 1000;
    lava_decreaseInTickTimePerLevel = 20;
    lava_millisUpdated = millis();
    lava_currentLevel = 3;
    
    // Colors
    backgroundColor = color(0);
    gridBackgroundColor = color(135, 206, 235);
    goalColor = color(203, 209, 25);
    
    // Block Texture
    stoneTexture = loadImage("stone.png");
    facade00 = loadImage("facade00.png");
    activeBlockTexture = stoneTexture;
    
    // Lava textures
    lavaTexture = loadImage("lava.png");
    lavaTexture2 = loadImage("lava2.png");
    background1 = loadImage("background1.png");
    lavaGif = new Gif(this, "animatedLava.gif");
    lavaGif.play();
    lavaGif2 = new Gif(this, "animatedLava2.gif");
    lavaGif2.play();
    
    // Menu
    muteTexture = loadImage("mute.png");
    unmuteTexture = loadImage("unmute.png");
    controlsTexture = loadImage("controls4.png");
    
    // Sound
    restartMusic();
    jump1 = new SoundFile(this, "jump.wav");
    crushed = new SoundFile(this, "crushed.mp3");
    
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
    
    // Moving piece with input
    movingPieceLeft = false;
    movingPieceRight = false;
    movingPieceDown = false;
    millisMovedPieceRight = millis();
    millisMovedPieceLeft = millis();
    millisMovedPieceDown = millis();
    
}

void setLavaTickTimeDependingOnDifficulty() {
    switch(difficulty) {
    case EASY:
        lava_initialTickTime = easy_lava_initialTickTime;
        lava_currentTickTime = lava_initialTickTime;
        return;
    case MEDIUM:
        lava_initialTickTime = medium_lava_initialTickTime;
        lava_currentTickTime = lava_initialTickTime;
        return;
    case HARD:
        lava_initialTickTime = hard_lava_initialTickTime;
        lava_currentTickTime = lava_initialTickTime;
        return;
    }
}

void gameOver() {
    gameState = GameState.GAMEOVER;
    saveCurrentScore();  // will only save if actually is new highscore
}

void resetGame() {
    initializeState();
    gameState = GameState.STARTSCREEN;
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
        startMenu.display();
        break;
    }
}

void restartMusic() {
    if (music1 == null || !music1.isPlaying()) {
        music1 = new SoundFile(this, "music1.mp3");
        music1.loop();
        music1.amp(musicFactor);
    }
}

void muteMusic() {
    if (soundIsMuted) {
        restartMusic();
    }
    else {
        music1.pause();
    }
    soundIsMuted = !soundIsMuted;
}
