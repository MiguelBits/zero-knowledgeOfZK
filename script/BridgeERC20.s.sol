pragma solidity ^0.8.9;

import "forge-std/Script.sol";
import "../src/bridge/BridgedERC20.sol";
import "../src/bridge/TokenVault.sol";

contract TestERC20 is ERC20Upgradeable{

    function initialize(string memory name, string memory symbol) public initializer {
        __ERC20_init(name, symbol, 18);
    }

    function mint(address account, uint256 amount) public {
        _mint(account, amount);
    }

}

contract BridgeEthScript is Script {

    address ethTokenVault = 0xD0dfd5baCf160B97C8eE3ecb463F18c08673160c;
    address taikoTokenVault = 0x0000777700000000000000000000000000000002;
    address USER = 0xe5ED6e083A49C5219Acce0093cd6279A996CF553;
    uint taikoChainId = 167003;
    uint256 gasLimit = 100000;
    uint processingFee = 0;
    address refundAddress = USER;
    string memo = "testing bridgooooor";
    function testBridging() public {

        vm.startBroadcast();

            TokenVault bridgedERC20 = TokenVault(ethTokenVault); //replace with the address of the bridged ERC20 token

            //deploy a test ERC20 token
            TestERC20 testERC20 = new TestERC20();
            testERC20.initialize("Test", "TST");

            uint _amount = 1000 ether;

            //mint some tokens
            testERC20.mint(address(this), _amount);

            //approve the bridged ERC20 token to spend our tokens
            testERC20.approve(address(bridgedERC20), _amount);

            //bridge the tokens
            bridgedERC20.sendERC20(taikoChainId, USER, address(testERC20), _amount, gasLimit, processingFee,refundAddress, memo);
            

        vm.stopBroadcast();
    }

    function testBridgeClaim() public {
        
    }
}