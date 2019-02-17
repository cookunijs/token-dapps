//Replace [] with your contract ABI
var contractABI = [
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "name": "tokenAddress",
        "type": "address"
      },
      {
        "indexed": false,
        "name": "sender",
        "type": "address"
      },
      {
        "indexed": false,
        "name": "name",
        "type": "string"
      },
      {
        "indexed": false,
        "name": "symbol",
        "type": "string"
      },
      {
        "indexed": false,
        "name": "decimals",
        "type": "uint8"
      },
      {
        "indexed": false,
        "name": "initialSupply",
        "type": "uint256"
      }
    ],
    "name": "SendToken",
    "type": "event",
    "signature": "0x8e66b9f40ca8f78abddc596f8bc5a4a8e44dd0960c2b87a0eb49ab4184a0ad2f"
  },
  {
    "constant": false,
    "inputs": [],
    "name": "deposit",
    "outputs": [],
    "payable": true,
    "stateMutability": "payable",
    "type": "function",
    "signature": "0xd0e30db0"
  },
  {
    "constant": false,
    "inputs": [
      {
        "name": "name",
        "type": "string"
      },
      {
        "name": "symbol",
        "type": "string"
      },
      {
        "name": "decimals",
        "type": "uint8"
      },
      {
        "name": "initialSupply",
        "type": "uint256"
      }
    ],
    "name": "requestToken",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function",
    "signature": "0x25d74cd7"
  },
  {
    "constant": true,
    "inputs": [],
    "name": "showTokenAddress",
    "outputs": [
      {
        "name": "",
        "type": "address"
      },
      {
        "name": "",
        "type": "string"
      },
      {
        "name": "",
        "type": "string"
      },
      {
        "name": "",
        "type": "uint8"
      },
      {
        "name": "",
        "type": "uint256"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function",
    "signature": "0x842594b0"
  }
];