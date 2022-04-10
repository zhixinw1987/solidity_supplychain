//proxy artifacts
const Proxy = artifacts.require("Proxy");
const Registry = artifacts.require("Registry");

//biz contracts
const ItemManager = artifacts.require("ItemManager");
const Item = artifacts.require("Item");


module.exports = async function (deployer, network, accounts) {

  const[proxyOwner] = accounts;
 
  //proxy contract deployment
  await deployer.deploy(Proxy, {from: proxyOwner});
  await deployer.deploy(Registry, {from: proxyOwner});

  //biz contracts deployment
  await deployer.deploy(ItemManager, {from: accounts[0]});
};
