pragma solidity 0.5.0;

import "./Token.sol";

contract DeployToken {

    Token private token;
    address private addressThis;
    struct userToken {
        address addressThis;
        string name;
        string symbol;
        uint8 decimals;
        uint256 initialSupply;
    }

    mapping(address => userToken) usersToken;
    event SendToken(address  tokenAddress, address sender, string name, string  symbol, uint8 decimals, uint256 initialSupply);
    
    function deployToken (string memory name, string memory symbol, uint8 decimals, uint256 initialSupply) public {
        token = new Token(name, symbol, decimals, initialSupply, msg.sender);
        addressThis = token.addressThis();
        usersToken[msg.sender].addressThis = addressThis;
        usersToken[msg.sender].name = name;
        usersToken[msg.sender].symbol = symbol;
        usersToken[msg.sender].decimals = decimals;
        usersToken[msg.sender].initialSupply = initialSupply;
        token.addMinter(msg.sender);
        emit SendToken(addressThis, msg.sender, name, symbol, decimals, initialSupply);
    }

    function showTokenAddress () public view returns(address, string memory, string memory, uint8, uint256){
        return (
            usersToken[msg.sender].addressThis,
            usersToken[msg.sender].name,
            usersToken[msg.sender].symbol,
            usersToken[msg.sender].decimals,
            usersToken[msg.sender].initialSupply
        );
    }

}