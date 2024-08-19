void keyPressed() {
    switch(gameState) {
    case GAMEACTIVE:
        keysPressedGAMEACTIVE();
        break;
    case GAMEOVER:
        keysPressedGAMEOVER();
        break;
    case STARTSCREEN:
        break;
    }
}

void keysPressedGAMEACTIVE() {
    handleBuildingInput(key);
    handleClimbingInput(key);
}

void keysPressedGAMEOVER() {
    if (key == ENTER || key == ' ') {
        resetGame();
    }
}

void handleBuildingInput(int key) {
    movePieceLeftRightOrDown();
    
    if (keyCode == UP) {
        currentPiece.tryToRotate();
    }
    
    if (key == 'x') {
        gameOver();    
    }

    if (key == 'c') {
        // Make current piece fall until a new piece is spawned.
        while (!makePieceFallOrSpawnNewPiece());
        lastTimeCheck = millis();
        makePieceFallOrSpawnNewPiece();
    }
    

    if (key == 'c') {
        holdCurrentPiece();
    }
}

void movePieceLeftRightOrDown() {
    if (movePieceNoDelay) {
        if (keyCode == LEFT) {
            movingPieceLeft = true;
        }
        if (keyCode == RIGHT) {
            movingPieceRight = true;
        }
        if (keyCode == DOWN) {
            movingPieceDown = true;
        }
    }
    else {
        if (keyCode == LEFT) {
            currentPiece.tryToMoveLeft();
        }
        if (keyCode == RIGHT) {
            currentPiece.tryToMoveRight();
        }
        if (keyCode == DOWN) {
            makePieceFallOrSpawnNewPiece();
        }
    }
}

void handleClimbingInput(int key) {
    if (key == 'a' || key == 'A') {
        player.movingLeft = true;  
    }
    if (key == 'd' || key == 'D') {
        player.movingRight = true;  
    }
    if (key == ' ' || key == 'w' || key == 'W') {
        player.jump(); 
    }
}

void keyReleased() {
    handleKeyReleasedBuilding();   
    handleKeyReleasedClimbing();    
}

void handleKeyReleasedBuilding() {
    if (keyCode == LEFT) {
        movingPieceLeft = false;  
    }
    if (keyCode == RIGHT) {
        movingPieceRight = false;  
    }    
    if (keyCode == DOWN) {
        movingPieceDown = false;  
    }    
}

void handleKeyReleasedClimbing() {
    if (key == 'a' || key == 'A') {
        player.movingLeft = false;  
    }
    if (key == 'd' || key == 'D') {
        player.movingRight = false;  
    }    
}
