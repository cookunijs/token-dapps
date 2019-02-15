<template>

  <div class="app">

    <div class="content">

      <h3>Example of a simple storage contract</h3>
      <input type="text" v-bind="name"><br>
      <input type="text" v-bind="symbol"><br>
      <input type="text" v-bind="decimals"><br>
      <input type="text" v-bind="initialSupply"><br>

      <button @click="updateValue">Token作成</button>

      <p v-if="contractAddress">The contract is deployed at {{contractAddress}}</p>

      <p v-if="!contractAddress">No contracts found</p>

      <p v-if="account">Current account: {{account}}</p>

      <p v-if="!account">No accounts found</p>

      <p v-if="TokenAddress">The contract is deployed at {{contractAddress}}</p>

      <p v-if="!TokenAddress">No contracts found</p>

      
    </div>

    <div class="message" v-if="message">{{message}}</div>

  </div>

</template>

 

<script>

import Web3 from 'web3'

import contract from 'truffle-contract'

import artifacts from '../build/contracts/DeployToken.json'

const DeployToken = contract(artifacts)

 

export default {
  name: 'app',
  data () {
    return {
      message: null,
      contractAddress: null,
      TokenAddress: null,
      account: null,
      name: null,
      symbol: null,
      decimals: 0,
      initialSupply: 0,
    }

  },

  created(){
    if (typeof web3 !== 'undefined') {
      // Use Mist/MetaMask's provider
      web3 = new Web3(web3.currentProvider);
    } else {
      console.warn("No web3 detected. Falling back to http://127.0.0.1:8545. You should remove this fallback when you deploy live, as it's inherently insecure. Consider switching to Metamask for development. More info here: http://truffleframework.com/tutorials/truffle-and-metamask")
    // fallback - use your fallback strategy (local node / hosted node + in-dapp id mgmt / fail)
      web3 = new Web3(new Web3.providers.HttpProvider("http://127.0.0.1:8545"))
    }
    
    DeployToken.setProvider(web3.currentProvider)
    web3.eth.getAccounts( (err, accs) => {

      if (err != null) {
        console.error(err)
        this.message = "There was an error fetching your accounts. Do you have Metamask, Mist installed or an Ethereum node running? If not, you might want to look into that"
        return
      }

      if (accs.length == 0) {
        this.message = "Couldn't get any accounts! Make sure your Ethereum client is configured correctly."
        return
      }

      this.account = accs[0];
      DeployToken.deployed()
        .then( (instance) => instance.address)
        .then( (address) => {
          this.contractAddress = address
          this.updateValue()
        })

    })

 

  },

  methods: {
      updateValue() {
        this.message = "Transaction started";
        return DeployToken.deployed()
          .then( (instance) => instance.deployToken(this.name, this.symbol, this.decimals, this.initialSupply, {from: this.account}))
          .then( () => {
            this.message = "Transaction done"
            this.showTokenAddress()
          })

          .catch( (e) => {
            console.error(e)
            this.message = "Transaction failed"
          })

      },

      showTokenAddress() {
        DeployToken.deployed().then( (instance) => instance.showTokenAddress()).then( (r) => {
          console.log(r.showTokenAddress())
          this.TokenAddress = r.showTokenAddress()
        });

      },

    },

 

}

</script>

 

<style lang="scss">

#app {

  font-family: 'Avenir', Helvetica, Arial, sans-serif;

  -webkit-font-smoothing: antialiased;

  -moz-osx-font-smoothing: grayscale;

  text-align: center;

  color: #2c3e50;

  margin-top: 60px;

}

 

h1, h2 {

  font-weight: normal;

}

 

ul {

  list-style-type: none;

  padding: 0;

}

 

li {

  display: inline-block;

  margin: 0 10px;

}

 

a {

  color: #42b983;

}

</style>

 

