pragma solidity 0.5.0;

import "./Token.sol";

contract DeployToken {

    Token private token;
    address private addressThis;
    struct sendToken {
        string name;
        string symbol;
        uint8 decimals;
        uint256 initialSupply;
    }
    struct userToken {
        address addressThis;
        string name;
        string symbol;
        uint8 decimals;
        uint256 initialSupply;
    }

    mapping(address => uint) amountList;
    mapping(address => sendToken) sendsToken;
    mapping(address => userToken) usersToken;
    event SendToken(address  tokenAddress, address sender, string name, string  symbol, uint8 decimals, uint256 initialSupply);

    function deposit() public payable{
        amountList[msg.sender] += msg.value;
    }

    function requestToken (string memory name, string memory symbol, uint8 decimals, uint256 initialSupply) public {
        sendsToken[msg.sender].name = name;
        sendsToken[msg.sender].symbol = symbol;
        sendsToken[msg.sender].decimals = decimals;
        sendsToken[msg.sender].initialSupply = initialSupply;
    }

    function deployToken () public {
        require(amountList[msg.sender] > 100000000000000000);
        require(sendsToken[msg.sender].initialSupply != 0);
        amountList[msg.sender] = 0;

        token = new Token(
            sendsToken[msg.sender].name,
            sendsToken[msg.sender].symbol,
            sendsToken[msg.sender].decimals,
            sendsToken[msg.sender].initialSupply,
            msg.sender
        );

        addressThis = token.addressThis();
        usersToken[msg.sender].addressThis = addressThis;
        usersToken[msg.sender].name = sendsToken[msg.sender].name;
        usersToken[msg.sender].symbol = sendsToken[msg.sender].symbol;
        usersToken[msg.sender].decimals = sendsToken[msg.sender].decimals;
        usersToken[msg.sender].initialSupply = sendsToken[msg.sender].initialSupply;
        token.addMinter(msg.sender);

        emit SendToken(
            addressThis,
            msg.sender,
            sendsToken[msg.sender].name,
            sendsToken[msg.sender].symbol,
            sendsToken[msg.sender].decimals,
            sendsToken[msg.sender].initialSupply
        );
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