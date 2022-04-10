const Proxy = artifacts.require("Proxy");
const Registry = artifacts.require("Registry");
const ItemManager = artifacts.require("ItemManager");

contract("proxy test", async (accounts) => {

    before(async() => {
        proxy = await Proxy.deployed();
        registry = await Registry.deployed();
        itemManager = await ItemManager.deployed();
    });

    it ("should not be able to add same contract", async() => {
        console.log(itemManager.address);

        result = await registry.addContract(itemManager.address);
        console.log(result.logs[0]);
        console.log("========================");
        result= await registry.addContract(itemManager.address);
        console.log(result.logs[0]);

    });

});