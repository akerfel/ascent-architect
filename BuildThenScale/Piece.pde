

abstract public class Piece {
    int x;
    int xOffset;
    int y;
    int rotation;        // Between 0 and 3
    color rgbColor;
    PVector[] blocks;

    public Piece() {
        rotation = 0;
        // blocks[] consists of four vectors which represent locations of the four blocks.
        // The first vector represent the block in top row which is furthest to the left, for rotation = 0.
        // That block has coordinates (0, 0), and all other blocks have coordinates in relation to that.
        blocks = new PVector[4];
    }

    // Needs to be overriden by subclasses
    abstract void setBlocksBasedOnRotation();

    // This function should be called in the end of the constructor for each subclass.
    // This is because some subclasses have an offset for the x-coordinate-start-position.
    // and some of the function calls in this function depend on the x-coordinate.
    void setupAfterSubclassConstructor() {
        setStartCoordinates();
        setBlocksBasedOnRotation();
        if (pieceIsCollidingWithFilledBlock()) {
            fillBlocks_and_checkIfGAMEOVER();
            gameState = GameState.GAMEOVER;
        }
    }

    void setStartCoordinates() {
        y = player.getYinGrid() - distancePiecesSpawnAbovePlayer;
        x = gridWidth/2 + xOffset - 1;
    }

    // Return true if rotation was succesful, otherwise false.
    boolean tryToRotate() {
        unfillBlocks();
        rotate();

        if (pieceIsOutsideGrid() || pieceIsCollidingWithFilledBlock()) {
            antiRotate();
            fillBlocks_and_checkIfGAMEOVER();
            return false;
        }

        setBlocksBasedOnRotation();
        fillBlocks_and_checkIfGAMEOVER();
        return true;
    }

    void rotate() {
        rotation++;
        rotation = rotation % 4;
        setBlocksBasedOnRotation();
    }

    void antiRotate() {
        rotation--;
        rotation = rotation % 4;
        if (rotation == -1) {
            rotation = 3;
        }
        setBlocksBasedOnRotation();
    }

    void setRotation(int newRotation) {
        rotation = newRotation;
        setBlocksBasedOnRotation();
    }

    // Returns true if the piece collides with an already filled block.
    // NOTE: You should probably only call this function if you first called unfillBlocks(), and then moved the piece.
    boolean pieceIsCollidingWithFilledBlock() {
        for (int i = 0; i < blocks.length; i++) {
            if (blockIsFilled(i)) {
                return true;
            }
        }
        return false;
    }

    boolean blockIsFilled(int blockIndex) {
        return grid.grid[getXCoordForBlock(blockIndex)][getYCoordForBlock(blockIndex)].isFilled;
    }

    boolean pieceIsOutsideGrid() {
        for (int i = 0; i < blocks.length; i++) {
            if (blockIsOutsideGrid(i)) {
                return true;
            }
        }
        return false;
    }

    boolean blockIsOutsideGrid(int blockIndex) {
        if (getXCoordForBlock(blockIndex) < 0 || getXCoordForBlock(blockIndex) > gridWidth - 1) {
            return true;
        }
        if (getYCoordForBlock(blockIndex) < 0 || getYCoordForBlock(blockIndex) > gridHeight - 1) {
            return true;
        }
        return false;
    }

    // Return true if piece moved to the left, otherwise false.
    boolean tryToMoveLeft() {
        unfillBlocks();
        x--;
        if (pieceIsOutsideGrid() || pieceIsCollidingWithFilledBlock()) {
            x++;
            fillBlocks_and_checkIfGAMEOVER();
            return false;
        }
        fillBlocks_and_checkIfGAMEOVER();
        return true;
    }

    // Return true if piece moved to the right, otherwise false.
    boolean tryToMoveRight() {
        unfillBlocks();
        x++;
        if (pieceIsOutsideGrid() || pieceIsCollidingWithFilledBlock()) {
            x--;
            fillBlocks_and_checkIfGAMEOVER();
            return false;
        }
        fillBlocks_and_checkIfGAMEOVER();
        return true;
    }

    int getXCoordForBlock(int blockIndex) {
        return x + int(blocks[blockIndex].x);
    }

    int getYCoordForBlock(int blockIndex) {
        return y + int(blocks[blockIndex].y);
    }

    void unfillBlocks() {
        for (int i = 0; i < 4; i++) {
            grid.grid[x + int(blocks[i].x)][y + int(blocks[i].y)].isFilled = false;
        }
    }

    void fillBlocks_and_checkIfGAMEOVER() {
        for (int i = 0; i < 4; i++) {
            PVector blockVec = blocks[i];
            //fillBlockAndSetColor(x + int(blockVec.x), y + int(blockVec.y), rgbColor); // no need for colors when we have textures
            int gridX = x + int(blockVec.x);
            int gridY = y + int(blockVec.y);
            
            grid.grid[gridX][gridY].isFilled = true;
            checkIfPlayerCrushedByBlock(gridX, gridY);
        }
    }
    
    private void checkIfPlayerCrushedByBlock(int gridX, int gridY) {
        if (gridX == player.getXinGrid() && gridY == player.getYinGrid()) {
            gameOver();
        } 
    }

    boolean fallOneStep_and_checkIfGAMEOVER() {
        unfillBlocks();
        y++;
        if (pieceIsOutsideGrid() || pieceIsCollidingWithFilledBlock()) {
            y--;
            fillBlocks_and_checkIfGAMEOVER();
            return false;
        }
        fillBlocks_and_checkIfGAMEOVER();
        return true;
    }

    int getXCoordForLeftmostBlock() {
        int leftmostX = gridWidth - 1;

        for (int i = 0; i < blocks.length; i++) {
            if (x + blocks[i].x < leftmostX) {
                leftmostX = int(x + blocks[i].x);
            }
        }
        return leftmostX;
    }

    int getXCoordForRightmostBlock() {
        int rightmostX = 0;

        for (int i = 0; i < blocks.length; i++) {
            if (x + blocks[i].x > rightmostX) {
                rightmostX = int(x + blocks[i].x);
            }
        }
        return rightmostX;
    }
}
