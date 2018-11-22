//General
final int MAX_KEYSPRESSED = 1024;
boolean[] keysPressed = new boolean[MAX_KEYSPRESSED];
boolean enterPressed = false;
boolean movePanels = false;

////////DEV-MODE////////
boolean devMode = true;

//Panels
final int MAX_PANELS = 11;
int txtSize = 40;
int startPanel = 4;
int sandBankIndex = 0;
int waveIndex = 5;
PImage water;
PImage wave;



//Player(s)
Player[] players;
final int MAX_BOATS = 3;
final int MAX_PLAYERS = 3;
float boatWidth = 15;
float boatHeight = 20;
float boatSpacing = 5;
int selectedPlayer = 0;
String[] playerColor = {"red", "green", "blue", "yellow"};

void mainSetup() {  
  //Panles
  water = loadImage("sprites/water.png");
  wave = loadImage("sprites/wave.png");
  createPanels();

  //Player
  players = new Player[MAX_PLAYERS];
  float tempBoatX = width/(MAX_BOATS + 1);
  for (int iPlayer = 0; iPlayer < MAX_PLAYERS; iPlayer++) {
    //if (iPlayer == 0) {
    //  players[iPlayer] = new Player(MAX_BOATS, startPanel, MAX_PLAYERS, tempBoatX, boatWidth, boatHeight, boatSpacing, playerColor[iPlayer]);
    //} else {
      players[iPlayer] = new Player(MAX_BOATS, startPanel, MAX_PLAYERS, tempBoatX * (iPlayer + 1), boatWidth, boatHeight, boatSpacing, playerColor[iPlayer]);
    //}
  }


  players[0].turn = true;
}
