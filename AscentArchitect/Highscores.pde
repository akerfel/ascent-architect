import java.util.Collections;
import java.util.stream.Collectors;

void createDataFolderIfDoesNotExist() {
  File dataFolder = new File(dataPath("data"));
  
  if (!dataFolder.exists()) {
    boolean success = dataFolder.mkdirs();
    if (success) {
      println("Folder 'data' created successfully.");
    } else {
      println("Failed to create folder 'data'.");
    }
  } else {
    println("Folder 'data' already exists.");
  }
}

String getCurrentHighscoreList() {
    switch (difficulty) {
        case EASY:
            return highscoresFileEasy;
        case MEDIUM:
            return highscoresFileMedium;
        case HARD:
            return highscoresFileHard;
        default:
            return "";
    }
}

void saveCurrentScore() {
    createFileIfMissing(getCurrentHighscoreList());
    ArrayList<Integer> highscores = getHighscores();            // load data/highscores.txt into arraylist
    highscores.add(score);                                      // add score to highscores arraylist
    Collections.sort(highscores, Collections.reverseOrder());   // sort highscores arraylist
    saveHighscores(highscores.stream().distinct().collect(Collectors.toCollection(ArrayList::new)));
}

void createFileIfMissing(String file) {
    File f = dataFile(file);  // automatically has "data/" in front
    boolean exists = f.isFile();
    if (!exists) {
        output = createWriter("data/" + file);
        output.close();
    }
}

// Load highscores.txt into int arraylist that is returned
ArrayList<Integer> getHighscores() {
    ArrayList<Integer> highscores = new ArrayList<Integer>();
    BufferedReader reader = createReader("data/" + getCurrentHighscoreList());
    String line = null;
    try {
        while ((line = reader.readLine()) != null) {
            highscores.add(int(line));
        }
        reader.close();
    }
    catch (IOException e) {
        e.printStackTrace();
    }
    return highscores;
}

// Save highscores from supplied arraylist into data/highscores.txt
void saveHighscores(ArrayList<Integer> highscores) {
    output = createWriter("data/" + getCurrentHighscoreList());
    int i = 0;
    for (int someScore : highscores) {
        output.println(str(someScore));
        i++;
        if (i >= 10) {
            break;
        }
    }
    output.close(); // Finishes the file
}
