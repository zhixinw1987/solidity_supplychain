const ItemManager = artifacts.require("ItemManager");
const Item = artifacts.require("Item");

module.exports = async function (deployer, network, accounts) {
  await deployer.deploy(ItemManager, {from: accounts[0]});
};
