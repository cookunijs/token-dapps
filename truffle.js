var HDWalletProvider = require("truffle-hdwallet-provider");
var mnemonic = "faith mean raccoon honey bullet away federal carbon inspire blast danger agent";
var accessToken = "v3/a57a307c3c4c4210ab39d3835b9ca8f8";


module.exports = {

       networks: {
           
           development: {
               host: "localhost",
               port: 8545,
               network_id: "10"

           },

	   ropsten: {

 	       provider: function() {

		    return new HDWalletProvider(
		         mnemonic, 
　　　　　　　　　　　　　　　　"https://ropsten.infura.io/" + accessToken, 1

                    );

	       },

   	       network_id: 3,
               gas: 500000,

	 }

       }


  };
