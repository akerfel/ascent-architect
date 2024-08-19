class StartMenu {
    Button playButton;
    Button settingsButton;
    Button quitButton;

    StartMenu() {
        playButton = new Button("Play", width / 2, 300);
        settingsButton = new Button("Settings", width / 2, 400);
        quitButton = new Button("Quit", width / 2, 500);
    }

    void display() {
        background(background1);
        fill(255);
        textSize(32);
        textAlign(CENTER, CENTER);
        text(gameTitle, width / 2, 100);

        playButton.display();
        settingsButton.display();
        quitButton.display();
        drawMuteIcon();

        // Display the instructions text below the buttons
        textSize(18);
        textAlign(CENTER, TOP);
        fill(255);

        float instructionsY = quitButton.y + quitButton.height / 2 + 50; // Position text below the quit button
        String[] instructions = {
            "Build & Climb.",
            "Don't crush the player.",
            "Avoid lava."
        };

        // Calculate the maximum width of the instructions
        float maxWidth = 0;
        for (String instruction : instructions) {
            float w = textWidth(instruction);
            if (w > maxWidth) {
                maxWidth = w;
            }
        }

        // Box dimensions with padding
        float boxWidth = maxWidth + 20; // Padding on both sides
        float boxHeight = instructions.length * 30 + 10; // Line height and padding

        // Draw the box
        stroke(255);
        noFill();
        rectMode(CENTER);
        rect(width / 2, instructionsY + boxHeight / 2, boxWidth, boxHeight);
        rectMode(CORNER);

        // Draw the instructions text
        fill(255);
        for (int i = 0; i < instructions.length; i++) {
            float textY = instructionsY + i * 30 + 10; // Line height and padding
            text(instructions[i], width / 2, textY);
        }

        // Display the controlsTexture at the bottom
        if (controlsTexture != null) {
            float imgWidth = controlsTexture.width;
            float imgHeight = controlsTexture.height;
            imageMode(CENTER);
            image(controlsTexture, width / 2, height - imgHeight * 1.5, imgWidth, imgHeight);
            imageMode(CORNER);
        }
    }

    void handleMousePressed() {
        if (playButton.isClicked(mouseX, mouseY)) {
            gameState = GameState.GAMEACTIVE;
        } else if (settingsButton.isClicked(mouseX, mouseY)) {
            // Transition to settings screen (not implemented in this example)
        } else if (quitButton.isClicked(mouseX, mouseY)) {
            exit(); // Exit the program
        }
    }
}

class Button {
    String label;
    float x, y;
    float width = 200;
    float height = 50;

    Button(String label, float x, float y) {
        this.label = label;
        this.x = x;
        this.y = y;
    }

    void display() {
        fill(255);
        rectMode(CENTER);
        rect(x, y, width, height, 10);
        fill(0);
        textSize(24);
        textAlign(CENTER, CENTER);
        text(label, x, y);
        rectMode(CORNER);
        textAlign(CORNER);
    }

    boolean isClicked(float mouseX, float mouseY) {
        return mouseX > x - width / 2 && mouseX < x + width / 2 &&
               mouseY > y - height / 2 && mouseY < y + height / 2;
    }
}
