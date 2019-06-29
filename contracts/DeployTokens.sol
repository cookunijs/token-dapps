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
        uint256 time;
    }
    
    mapping(address => userToken[]) usersToken;
    event SendToken(address  tokenAddress, address sender, string name, string  symbol, uint8 decimals, uint256 initialSupply, uint256 time);

    function deployToken (string memory name, string memory symbol, uint8 decimals, uint256 initialSupply) public {
        token = new Token(
            name,
            symbol,
            decimals,
            initialSupply,
            msg.sender
        );

        userToken memory CreateToken;
        addressThis = token.addressThis();
        CreateToken.addressThis = addressThis;
        CreateToken.name = name;
        CreateToken.symbol = symbol;
        CreateToken.decimals = decimals;
        CreateToken.initialSupply = initialSupply;
        CreateToken.time = now;
        token.addMinter(msg.sender);

        usersToken[msg.sender].push(CreateToken);
        
        emit SendToken(
            addressThis,
            msg.sender,
            name,
            symbol,
            decimals,
            initialSupply,
            CreateToken.time
        );
    }

    function showToken (uint _index) public view returns(address, string memory, string memory, uint8, uint256, uint256){
        return (
            usersToken[msg.sender][_index].addressThis,
            usersToken[msg.sender][_index].name,
            usersToken[msg.sender][_index].symbol,
            usersToken[msg.sender][_index].decimals,
            usersToken[msg.sender][_index].initialSupply,
            usersToken[msg.sender][_index].time
        );
    }
    
    function userTokenListLength () public view returns(uint256){
        return (
            usersToken[msg.sender].length
        );
    }

}