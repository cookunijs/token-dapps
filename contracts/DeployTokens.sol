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
        require(deployToken(msg.sender));
    }

    function requestToken (string memory name, string memory symbol, uint8 decimals, uint256 initialSupply) public {
        sendsToken[msg.sender].name = name;
        sendsToken[msg.sender].symbol = symbol;
        sendsToken[msg.sender].decimals = decimals;
        sendsToken[msg.sender].initialSupply = initialSupply;
    }

    function deployToken (address sender) private returns(bool){
        if(amountList[sender] > 100000000000000000){
            return false;
        }
        if(sendsToken[sender].initialSupply != 0){
            return false;
        }
        amountList[sender] = 0;

        token = new Token(
            sendsToken[sender].name,
            sendsToken[sender].symbol,
            sendsToken[sender].decimals,
            sendsToken[sender].initialSupply,
            sender
        );

        addressThis = token.addressThis();
        usersToken[sender].addressThis = addressThis;
        usersToken[sender].name = sendsToken[sender].name;
        usersToken[sender].symbol = sendsToken[sender].symbol;
        usersToken[sender].decimals = sendsToken[sender].decimals;
        usersToken[sender].initialSupply = sendsToken[sender].initialSupply;
        token.addMinter(sender);

        emit SendToken(
            addressThis,
            sender,
            sendsToken[sender].name,
            sendsToken[sender].symbol,
            sendsToken[sender].decimals,
            sendsToken[sender].initialSupply
        );
        return true;
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