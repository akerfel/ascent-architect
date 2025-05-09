void mousePressed() {
    if (gameState == GameState.STARTSCREEN) {
        startMenu.handleMousePressed();
    }
    else if (gameState == GameState.GAMEOVER) {
        gameOverMenu.handleMousePressed();
    }
    if (gameState == GameState.STARTSCREEN || gameState == GameState.GAMEOVER) {
        if (mouseX >= 0 && mouseX <= pixelsPerBlock && mouseY >= 0 && mouseY <= pixelsPerBlock) {
            muteMusic();    
        }
    }
}

void keyPressed() {
    switch(gameState) {
    case GAMEACTIVE:
        keysPressedGAMEACTIVE();
        break;
    case STARTSCREEN:
        break;
    }
}

void keysPressedGAMEACTIVE() {
    handleBuildingInput(key);
    handleClimbingInput(key);
}

void handleBuildingInput(int key) {
    movePieceLeftRightOrDown();
    
    if (keyCode == UP) {
        currentPiece.tryToRotate();
    }
    
    if (keyCode == SHIFT) {
        // Make current piece fall until a new piece is spawned.
        while (!makePieceFallOrSpawnNewPiece());
        lastTimeCheck = millis();
        makePieceFallOrSpawnNewPiece();
    }
    
    if (key == 'i') {
        movePieceNoDelay = !movePieceNoDelay;    
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
