pragma solidity >=0.4.22 <0.6.0;

contract BetOnOneAnimal {
  address owner;

  struct Bet {
    address payable sender;
    uint animal;
    bool voted;
  }

  mapping(address => Bet) bets;
  Bet[] bets;
  address payable[] winningPlayers;
  string[] animals = ["Avestruz", "Águia", "Burro","Borboleta","Cachorro","Cabra","Carneiro","Camelo","Cobra","Coelho","Cavalo","Elefante","Galo","Gato","Jacaré","Leão","Macaco","Porco","Pavão","Peru","Touro","Tigre","Urso","Veado","Vaca"];
  uint numBets = 0;
  uint WinningNumber = 26;

  constructor() public {
    owner = msg.sender;
  }

  modifier onlyOwner() {
      require (msg.sender ==  owner, "Only the contract owner can execute this");
      _;
  }

  modifier minCost(uint min) {
    require(msg.value >= min, "Minumum value of 1000 to bet");
    _;
  }

  event sentPrize(uint totalPrize,uint idividualPrize);
  event changeSent(address player, uint change);

  function vote(uint number) public payable minCost(1000){
    Bet storage sender = bets[msg.sender];
    if (sender.voted || number > 26) return;
    sender.voted = true;
    sender.animal = number - 1;
    bets.push(sender);
    numBets++;

    if(msg.value > 1000){
      uint change = msg.value - 1000;
      msg.sender.transfer(change);
      emit changeSent(msg.sender, change);
    }
  }

  function getBet() public view returns(string memory _animalSelected){
    Bet storage sender = bets[msg.sender];
    return animals[sender.animal];
  }

  function setWinningAnimal() public onlyOwner() returns(string memory _animalSelected){
    require(numBets > 100, "Minumum quantity of 100 bets");
    if(WinningNumber == 26){
      WinningNumber = random(block.timestamp);
    }
    return animals[WinningNumber];
  }

  function sendMoneyToWinners() public onlyOwner() returns(uint _LastNumSelected) {
    require(numBets > 100, "Minumum quantity of 100 bets");
    for(uint p = 0; p < bets.length; p++){
      address payable player = bets[p].sender;
      if(bets[p].animal == WinningNumber){
        winningPlayers.push(player);
      }
    }

    uint totalPrize = address(this).balance;

    if(winningPlayers.length > 0){
      uint idividualPrize = totalPrize / winningPlayers.length;

      for(uint p = 0; p < winningPlayers.length; p++){
        winningPlayers[p].transfer(idividualPrize);
      }
      emit sentPrize(totalPrize,idividualPrize);
    }

    return WinningNumber;
  }

  function getWinners() public view returns(address payable[] memory _winningPlayers) {
    require(numBets > 100, "Minumum quantity of 100 bets");
    return winningPlayers;
  }

  function random(uint seed) private view returns (uint) {
    seed = (seed % 25);
    return seed;
  }
}
