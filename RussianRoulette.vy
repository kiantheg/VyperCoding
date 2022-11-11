players: public(DynArray[address,100])
losers: public(DynArray[address,100])
odds: public(uint256)
playersTurn: public(uint256)
creator: public(address)

@external
def __init__ (creator: address):
    self.creator = creator
@external
def setOdds (oneInThisMany: uint256):
    assert block.coinbase == self.creator
    self.odds = oneInThisMany

@external
def addPlayer (player: address):
    assert player not in self.players
    assert player not in self.losers
    self.players.append(player)

@internal
def lose (player: address):
    assert player not in self.losers
    for k in self.players:
        self.players.pop()
    self.losers.append(player)

@external
def random() -> (uint256):
    return block.number % self.odds

@external 
def play():
    randNum: uint256 = self.random()
    currPlayer: address = self.players[playersTurn]
    if randNum == 1:
        lose(currPlayer)
    else:
        playersTurn = playersTurn + 1

@external
def isALoser(person: address) -> (bool):
    return person in self.losers
