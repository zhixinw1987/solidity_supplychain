const ItemManager = artifacts.require("ItemManager");
const Item = artifacts.require("Item");
const trufferAssert = require("truffle-assertions");

contract ("ItemManagerTest", async (accounts) => {
    before (async() => {
        itemManager = await ItemManager.deployed();
    })

    item = 0;

    it("should be able to create item", async() => {
        result = await itemManager.createItem("ABC", "book", 100);
        item = result.logs[0].args[2]
    })

    it ("should not be able to create with same serial", async() => {
        await trufferAssert.reverts(itemManager.createItem("ABC", "book", 100));
    })
})