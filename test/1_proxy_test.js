const Proxy = artifacts.require("Proxy");
const Registry = artifacts.require("Registry");
const ItemManager = artifacts.require("ItemManager");

contract("proxy test", async (accounts) => {

    const[proxyOwner] = accounts;

    before(async() => {
        proxy = await Proxy.deployed();
        registry = await Registry.deployed();
        itemManager = await ItemManager.deployed();

        await registry.addContract(itemManager.address, {from: proxyOwner});
    });

    it ("should not be able to add same contract", async() => {
        console.log("before test");
        result= await registry.addContract(itemManager.address);
        console.log("=============================");
        console.log(result.logs[0]);

        console.log("+++++++++++++++++++++++++");
        console.log(await registry.getContracts());

    });

});